//
//  FirebaseInterface.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/5/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseInterface : ObservableObject {
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    @Published var signedIn = false
    @Published var currentUser : User? = nil
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    // Auth Methods
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //success
            self?.getUser()
        }
    }
    
    func signUp(name: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            //success
            if (self?.auth.currentUser != nil) {
                self?.userDBSetup(id: (self?.auth.currentUser!.uid)!, name: name, email: email)
            } else {
                print("currentUser not ready")
            }
        }
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            return true
        } catch {
            return false
        }
    }
    
    //
    // Firestore
    //
    
    // User Methods
    
    func getUser() {
        let docRef = db.collection("accounts").document(auth.currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: UserDB.self)
            }
            
            switch result {
                case .success(let user):
                    if let user = user {
                        self.convertUserDBtoUser(userDb: user)
                        // groupID != nil get group
                    } else {
                        // let user know eventually
                        print("document does not exist")
                    }
                case .failure(let error):
                    print("Error decoding user: \(error)")
            }
        }
    }
    
    func userDBSetup(id: String, name: String, email: String) {
        let recipesOfWeek : [String:[RecipeApi]] = [
            DaysOfWeek.Unassigned.str:[],
            DaysOfWeek.Sunday.str:[],
            DaysOfWeek.Monday.str:[],
            DaysOfWeek.Tuesday.str:[],
            DaysOfWeek.Wednesday.str:[],
            DaysOfWeek.Thursday.str:[],
            DaysOfWeek.Friday.str:[],
            DaysOfWeek.Saturday.str:[]
        ]
        
        let weeklyUserData : [String: Any] = [
            "startDate": Timestamp(date: Date()),
            "personalList": [],
            "recipesOfWeek": recipesOfWeek
        ]
        
        let weeklyUserDataArray = [weeklyUserData]
        
        let user : [String: Any] = [
            "name": name,
            "email": email,
            "pantryList": [],
            "savedRecipes": [],
            "weeklyUserData": weeklyUserDataArray
        ]
        
        db.collection("accounts").document(id).setData(user) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.getUser()
            }
        }
    }
    
    func updateDB() {
        let userdb : UserDB = convertUserToUserDB()
        
        do {
            try db.collection("accounts").document(userdb.id!).setData(from: userdb)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
        self.objectWillChange.send()
    }
    
    //    func getRealtimePersonalList() {
    //        db.collection("accounts").document(currentUser!.id).addSnapshotListener { (documentSnapshop, error) in
    //            guard let document = documentSnapshop else {
    //                print("No doucments. Error: \(error!)")
    //                return
    //            }
    //            guard let data = document.data() else {
    //                print("Document data was empty.")
    //                return
    //            }
    //
    //            print(data)
    //        }
    //    }
    
    // Conversion Methods -- From DB to App
    
    func convertUserDBtoUser(userDb: UserDB) {
        let ingArray = self.convertApitoIngs(ingsApi: userDb.pantryList)
        let savedRecipes = self.convertApitoRecipeArray(recArr: userDb.savedRecipes)
        let wud = convertWUDDBtoWUD(wud: userDb.weeklyUserData)
        self.currentUser = User(id: auth.currentUser!.uid, email: userDb.email, name: userDb.name, pantryList: ingArray, savedRecipes: savedRecipes, weeklyUserData: wud)
        
        self.signedIn = true
    }
    
    func convertApitoIngs(ingsApi: [IngredientApi]) -> [Ingredient] {
        var ings: [Ingredient] = []
        for ing in ingsApi {
            ings.append(Ingredient(id: ing.foodId!, text: ing.text!, quantity: ing.quantity!, measure: ing.measure, food: ing.food!, weight: ing.weight!, foodCategory: ing.foodCategory!, imgUrl: ing.image))
        }
        return ings
    }
    
    func convertApitoRecipe(recApi: RecipeApi) -> Recipe {
        let ingArray = self.convertApitoIngs(ingsApi: recApi.ingredients!)
        return Recipe(id: recApi.uri!, name: recApi.label!, imgUrl: recApi.image!, sourceUrl: recApi.url!, yield: recApi.yield!, ingString: recApi.ingredientLines!, ingredients: ingArray, calories: recApi.calories!, cuisineType: recApi.cuisineType!, mealType: recApi.mealType!)
    }
    
    func convertApitoRecipeArray(recArr: [RecipeApi]) -> [Recipe] {
        var newArr: [Recipe] = []
        for rec in recArr {
            newArr.append(self.convertApitoRecipe(recApi: rec))
        }
        return newArr
    }
    
    func convertWUDDBtoWUD(wud: [WeeklyUserDataDB]) -> [WeeklyUserData] {
        var newWud : [WeeklyUserData] = []
        for data in wud {
            let newDate = data.startDate
            let newPL = convertApitoIngs(ingsApi: data.personalList)
            var newROW: [DaysOfWeek:[Recipe]] = [:]
            for val in DaysOfWeek.allCases {
                newROW[val] = self.convertApitoRecipeArray(recArr: data.recipesOfWeek[val.str]!)
            }
            newWud.append(WeeklyUserData(startDate: newDate, personalList: newPL, recipesOfWeek: newROW))
        }
        return newWud
    }
    
    // Conversion Methods -- App to DB
    
    func convertUserToUserDB() -> UserDB {
        let pantryList = convertIngsToApi(ings: currentUser!.pantryList)
        let savedRecipes = convertRecipeArraytoApi(recArr: currentUser!.savedRecipes)
        let wud = convertWUDtoWUDDB(wud: currentUser!.weeklyUserData)
        return UserDB(id: currentUser?.id, email: currentUser!.email, name: currentUser!.name, pantryList: pantryList, savedRecipes: savedRecipes, weeklyUserData: wud)
    }
    
    func convertIngsToApi(ings: [Ingredient]) -> [IngredientApi] {
        var ingsApi: [IngredientApi] = []
        for ing in ings {
            ingsApi.append(IngredientApi(text: ing.text, quantity: ing.quantity, measure: ing.measure, food: ing.food, weight: ing.weight, foodCategory: ing.foodCategory, foodId: ing.id, image: ing.imgUrl))
        }
        return ingsApi
    }
    
    func convertRecipetoApi(rec: Recipe) -> RecipeApi {
        let ingArray = self.convertIngsToApi(ings: rec.ingredients)
        return RecipeApi(uri: rec.id, label: rec.name, image: rec.imgUrl, source: nil, url: rec.sourceUrl, shareAs: nil, yield: rec.yield, dietLabels: nil, healthLabels: nil, cautions: nil, ingredientLines: rec.ingString, ingredients: ingArray, calories: rec.calories, glycemicIndex: nil, totalCO2Emissions: nil, co2EmissionsClass: nil, totalWeight: nil, cuisineType: rec.cuisineType, mealType: rec.mealType, dishType: nil, totalNutrients: nil, totalDaily: nil, digest: nil)
    }
    
    func convertRecipeArraytoApi(recArr: [Recipe]) -> [RecipeApi] {
        var newArr: [RecipeApi] = []
        for rec in recArr {
            newArr.append(self.convertRecipetoApi(rec: rec))
        }
        return newArr
    }
    
    func convertWUDtoWUDDB(wud: [WeeklyUserData]) -> [WeeklyUserDataDB] {
        var wudDb : [WeeklyUserDataDB] = []
        for data in wud {
            let newDate = data.startDate
            let newPL = convertIngsToApi(ings: data.personalList)
            var newROW: [String:[RecipeApi]] = [:]
            for val in DaysOfWeek.allCases {
                newROW[val.str] = self.convertRecipeArraytoApi(recArr: data.recipesOfWeek[val]!)
            }
            wudDb.append(WeeklyUserDataDB(startDate: newDate, personalList: newPL, recipesOfWeek: newROW))
        }
        return wudDb
    }
    
    // Get User Data Methods
    
    func getRecipesOfWeek() -> [DaysOfWeek:[Recipe]] {
        return currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].recipesOfWeek
    }
    
    
    // Mutate CurrentUser Methods
    
    func addRecipeToWeeklyData(recipe: Recipe) {
        var wud = currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1]
        wud.recipesOfWeek[DaysOfWeek.Unassigned]!.append(recipe)
        
        for ingredient in recipe.ingredients {
            if (wud.personalList.contains(ingredient)) {
                wud.personalList[wud.personalList.firstIndex(of: ingredient)!].quantity += ingredient.quantity
            } else {
                wud.personalList.append(ingredient)
            }
        }
        
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1] = wud
        updateDB()
    }
    
    func saveRecipe(recipe: Recipe) {
        currentUser!.savedRecipes.append(recipe)
        
        updateDB()
    }
    
    func unsaveRecipe(recipe: Recipe) {
        for index in 0 ..< currentUser!.savedRecipes.count {
            if (currentUser!.savedRecipes[index].id == recipe.id) {
                print("Unsave: \(index)")
                currentUser!.savedRecipes.remove(at: index)
                break
            }
        }
        
        updateDB()
    }
    
    func addIngredientToPersonalList(ingredient: Ingredient) {
        if (currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.contains(ingredient)) {
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity += ingredient.quantity
        } else {
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.append(ingredient)
        }
        
        updateDB()
    }
    
    func deleteIngredientFromPersonalList(ingredient: Ingredient) {
        var wud = currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1]
        
        for index in 0 ..< wud.personalList.count {
            if (wud.personalList[index].id == ingredient.id) {
                wud.personalList.remove(at: index)
                break
            }
        }
        
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1] = wud
        updateDB()
    }
    
    // Group Methods
    
    func createGroup() {
        let leaderID = currentUser?.id
        print(leaderID ?? "No id")
        // leaderID cannot be nil, the only way it would be is if the user is not signed in(though all
        // users need to be signed in) If leaderID is nil, that will lead to a lot of problems later on
        var g = Groups(groupID: "test", groupList: [], leaderID: leaderID ?? "nil", members: [])
    }
    
    func inGroup() -> Bool {
        if(currentUser?.groupID != nil){
            return true
        }
        else {
            return false
        }
    }
    
    // Misc Methods
    
    func searchSavedRecipes(text: String) -> [Recipe] {
        let lowerText = text.lowercased()
        var searchedRecipes: [Recipe] = []
        for recipe in currentUser!.savedRecipes {
            if recipe.name.lowercased().contains(lowerText) {
                searchedRecipes.append(recipe)
            }
        }
        return searchedRecipes
    }
    
    func searchPersonalList(text: String) -> [Ingredient] {
        let lowerText = text.lowercased()
        var searchedIngredient: [Ingredient] = []
        for ingredient in currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList {
            print(ingredient.food)
            if ingredient.food.lowercased().contains(lowerText) {
                searchedIngredient.append(ingredient)
            }
        }
        return searchedIngredient
    }
}
