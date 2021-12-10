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
import SwiftUI

class FirebaseInterface : ObservableObject {
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    @Published var signedIn = false
    @Published var hasGroup = false
    @Published var currentUser : User? = nil
    @Published var currentGroup : Group? = nil
    
    @Published var authError = false
    @Published var errorMsg = ""
    
    var changeCheck: DispatchWorkItem?
    
    var liveGroupListener : ListenerRegistration? = nil
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    // Auth Methods
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print("Email or password is incorrect")
                self?.authError = true
                self?.errorMsg = error!.localizedDescription
                return
            }
            
            //success
            self?.getUser()
        }
    }
    
    func signUp(name: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print("Error creating account")
                print(error!.localizedDescription)
                self?.authError = true
                self?.errorMsg = error!.localizedDescription
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
            //            self.currentUser = nil
            self.signedIn = false
            self.hasGroup = false
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
            guard document != nil, error == nil else {
                print("Error: " + error!.localizedDescription)
                self.signedIn = false
                return
            }
            let result = Result {
                try document?.data(as: UserDB.self)
            }
            
            switch result {
            case .success(let user):
                if let user = user {
                    self.convertUserDBtoUser(userDb: user)
                    if(!user.groupID.isEmpty) {
                        self.getGroup(groupID: user.groupID)
                    }
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
            "startDate": Timestamp(date: self.setInitalStartDate()),
            "personalList": [],
            "recipesOfWeek": recipesOfWeek
        ]
        
        let weeklyUserDataArray = [weeklyUserData]
        
        let groupID = ""
        
        let user : [String: Any] = [
            "name": name,
            "email": email,
            "pantryList": [],
            "savedRecipes": [],
            "weeklyUserData": weeklyUserDataArray,
            "groupID": groupID
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
        if (changeCheck != nil) {
            changeCheck!.cancel()
            changeCheck = nil
        }
        print("update called")
        
        changeCheck = DispatchWorkItem {
            print("executed")
            let userdb : UserDB = self.convertUserToUserDB(user: self.currentUser!)
            
            do {
                try self.db.collection("accounts").document(userdb.id!).setData(from: userdb)
            } catch let error {
                print("Error writing user to Firestore: \(error)")
            }
            
            self.objectWillChange.send()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: changeCheck!)
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
        self.currentUser = User(id: auth.currentUser!.uid, email: userDb.email, name: userDb.name, pantryList: ingArray, savedRecipes: savedRecipes, weeklyUserData: wud, groupID: userDb.groupID)
        
        self.signedIn = true
        self.checkForWUDRefresh()
    }
    
    func convertApitoIngs(ingsApi: [IngredientApi]) -> [Ingredient] {
        var ings: [Ingredient] = []
        for ing in ingsApi {
            ings.append(Ingredient(id: ing.foodId!, text: ing.text!, quantity: ing.quantity!, measure: ing.measure, food: ing.food!, weight: ing.weight!, foodCategory: ing.foodCategory, imgUrl: ing.image))
        }
        return ings.sorted(by: { $0.food.lowercased() < $1.food.lowercased() })
    }
    
    func convertApitoRecipe(recApi: RecipeApi) -> Recipe {
        let ingArray = self.convertApitoIngs(ingsApi: recApi.ingredients!)
        return Recipe(id: recApi.uri!, name: recApi.label!, imgUrl: recApi.image, sourceUrl: recApi.url, yield: recApi.yield!, ingString: recApi.ingredientLines, ingredients: ingArray, calories: recApi.calories, cuisineType: recApi.cuisineType, mealType: recApi.mealType, recipeInstructions: recApi.recipeInstructions)
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
    
    func convertUserToUserDB(user: User) -> UserDB {
        let pantryList = convertIngsToApi(ings: user.pantryList)
        let savedRecipes = convertRecipeArraytoApi(recArr: user.savedRecipes)
        let wud = convertWUDtoWUDDB(wud: user.weeklyUserData)
        return UserDB(id: user.id, email: user.email, name: user.name, pantryList: pantryList, savedRecipes: savedRecipes, weeklyUserData: wud, groupID: user.groupID)
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
        return RecipeApi(uri: rec.id, label: rec.name, image: rec.imgUrl, source: nil, url: rec.sourceUrl, shareAs: nil, yield: rec.yield, dietLabels: nil, healthLabels: nil, cautions: nil, ingredientLines: rec.ingString, ingredients: ingArray, calories: rec.calories, glycemicIndex: nil, totalCO2Emissions: nil, co2EmissionsClass: nil, totalWeight: nil, cuisineType: rec.cuisineType, mealType: rec.mealType, dishType: nil, totalNutrients: nil, totalDaily: nil, digest: nil, recipeInstructions: rec.recipeInstructions)
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
    func updateUserRecipesOfWeek(initialDay: DaysOfWeek, newDay: DaysOfWeek, recipe: Recipe){
        var recipesOfWeek = getRecipesOfWeek()
        var recipeDayList: [Recipe]
        //remove from initial day
        if recipesOfWeek[initialDay] != nil {
            recipeDayList = recipesOfWeek[initialDay]!
            if recipeDayList.firstIndex(of: recipe) != -1 {
                let indexToRemove = recipeDayList.firstIndex(where: { $0.name == recipe.name })
                recipeDayList.remove(at: indexToRemove!)
                recipesOfWeek[initialDay] = recipeDayList
            }
        }
        //add to new day
        recipeDayList = recipesOfWeek[newDay]!
        recipeDayList.append(recipe)
        recipesOfWeek[newDay] = recipeDayList
        
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].recipesOfWeek = recipesOfWeek
        updateDB()
    }
    
    func deleteRecipeFromUserRecipesOfWeek(day: DaysOfWeek, recipe: Recipe){
        var recipesOfWeek = getRecipesOfWeek()
        var recipeDayList: [Recipe]
        //remove from initial day
        if recipesOfWeek[day] != nil {
            recipeDayList = recipesOfWeek[day]!
            if recipeDayList.firstIndex(of: recipe) != -1 {
                let indexToRemove = recipeDayList.firstIndex(where: { $0.name == recipe.name })
                recipeDayList.remove(at: indexToRemove!)
                recipesOfWeek[day] = recipeDayList
            }
        }
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].recipesOfWeek = recipesOfWeek
        updateDB()
    }
    
    
    func addRecipeToWeeklyData(recipe: Recipe) {
        var wud = currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1]
        wud.recipesOfWeek[DaysOfWeek.Unassigned]!.append(recipe)
        
        for ingredient in recipe.ingredients {
            if (wud.personalList.contains(ingredient)) {
                let i = wud.personalList.firstIndex(of: ingredient)!
                wud.personalList[i].quantity += ingredient.quantity
                wud.personalList[i].qty = Quantity(amt: wud.personalList[i].quantity, unit: wud.personalList[i].unit!)
            } else {
                var changed = false
                for (index, ing) in wud.personalList.enumerated() {
                    if (ing.id == ingredient.id) {
                        if (ing.unit == ingredient.unit) {
                            wud.personalList[index].quantity += ingredient.quantity
                            wud.personalList[index].qty = Quantity(amt: wud.personalList[index].quantity, unit: wud.personalList[index].unit!)
                        } else {
                            var newQty : Quantity
                            if (!UnitConverter.isConvertable(q1: ing.qty!, q2: ingredient.qty!)) {
                                break;
                            }
                            newQty = UnitConverter.convertUnit(q1: ing.qty!, q2: ingredient.qty!)
                            
                            wud.personalList[index].qty = newQty
                            wud.personalList[index].quantity = newQty.amt
                            wud.personalList[index].unit = newQty.unit
                            wud.personalList[index].measure = newQty.unit.str
                        }
                        changed = true
                    }
                }
                if (!changed) {
                    wud.personalList.append(ingredient)
                }
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
                currentUser!.savedRecipes.remove(at: index)
                break
            }
        }
        
        updateDB()
    }
    
    func addIngredientToPersonalList(ingredient: Ingredient) {
        print("addIngredientToPersonalList called")
        if (currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.contains(ingredient)) {
            let i = currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[i].quantity += ingredient.quantity
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[i].qty = Quantity(amt: currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[i].quantity, unit: currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[i].unit!)
        } else {
            var changed = false
            for (index, ing) in currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.enumerated() {
                if (ing.id == ingredient.id) {
                    if (ing.unit == ingredient.unit) {
                        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].quantity += ingredient.quantity
                        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].qty = Quantity(amt: currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].quantity, unit: currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].unit!)
                    } else {
                        var newQty : Quantity
                        if (!UnitConverter.isConvertable(q1: ing.qty!, q2: ingredient.qty!)) {
                            break;
                        }
                        newQty = UnitConverter.convertUnit(q1: ing.qty!, q2: ingredient.qty!)
                        
                        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].qty = newQty
                        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].quantity = newQty.amt
                        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].unit = newQty.unit
                        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].measure = newQty.unit.str
                    }
                    changed = true
                    break
                }
            }
            if (!changed) {
                currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.append(ingredient)
            }
        }
        
        updateDB()
    }
    
    func deleteIngredientFromPersonalList(ingredient: Ingredient) {
        print("deleteIngredientFromPersonalList called")
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
    
    func addIngredientToPantryList(ingredient: Ingredient) {
        print("addIngredientToPantryList called")
        if (currentUser!.pantryList.contains(ingredient)) {
            let i = currentUser!.pantryList.firstIndex(of: ingredient)!
            currentUser!.pantryList[i].quantity += ingredient.quantity
            currentUser!.pantryList[i].qty = Quantity(amt: currentUser!.pantryList[i].quantity, unit: currentUser!.pantryList[i].unit!)
        } else {
            var changed = false
            for (index, ing) in currentUser!.pantryList.enumerated() {
                if (ing.id == ingredient.id) {
                    if (ing.unit == ingredient.unit) {
                        currentUser!.pantryList[index].quantity += ingredient.quantity
                        currentUser!.pantryList[index].qty = Quantity(amt: currentUser!.pantryList[index].quantity, unit: currentUser!.pantryList[index].unit!)
                    } else {
                        var newQty : Quantity
                        if (!UnitConverter.isConvertable(q1: ing.qty!, q2: ingredient.qty!)) {
                            break;
                        }
                        newQty = UnitConverter.convertUnit(q1: ing.qty!, q2: ingredient.qty!)
                        
                        currentUser!.pantryList[index].qty = newQty
                        currentUser!.pantryList[index].quantity = newQty.amt
                        currentUser!.pantryList[index].unit = newQty.unit
                        currentUser!.pantryList[index].measure = newQty.unit.str
                    }
                    changed = true
                    break
                }
            }
            if (!changed) {
                currentUser!.pantryList.append(ingredient)
            }
        }
        
        updateDB()
    }
    
    func deleteIngredientFromPantryList(ingredient: Ingredient) {
        print("deleteIngredientFromPantryList called")
        var pl = currentUser!.pantryList
        
        for index in 0 ..< pl.count {
            if (pl[index].id == ingredient.id) {
                pl.remove(at: index)
                break
            }
        }
        
        currentUser!.pantryList = pl
        updateDB()
    }
    
    func addIngredientToGroupList(ingredient: Ingredient) {
        print("addIngredientToGroupList called")
        
        if (currentGroup!.groupList.contains(ingredient)) {
            let i = currentGroup!.groupList.firstIndex(of: ingredient)!
            currentGroup!.groupList[i].quantity += ingredient.quantity
            currentGroup!.groupList[i].qty = Quantity(amt: currentGroup!.groupList[i].quantity, unit: currentGroup!.groupList[i].unit!)
        } else {
            var changed = false
            for (index, ing) in currentGroup!.groupList.enumerated() {
                if (ing.id == ingredient.id) {
                    if (ing.unit == ingredient.unit) {
                        currentGroup!.groupList[index].quantity += ingredient.quantity
                        currentGroup!.groupList[index].qty = Quantity(amt: currentGroup!.groupList[index].quantity, unit: currentGroup!.groupList[index].unit!)
                    } else {
                        var newQty : Quantity
                        if (!UnitConverter.isConvertable(q1: ing.qty!, q2: ingredient.qty!)) {
                            break;
                        }
                        newQty = UnitConverter.convertUnit(q1: ing.qty!, q2: ingredient.qty!)
                        
                        currentGroup!.groupList[index].qty = newQty
                        currentGroup!.groupList[index].quantity = newQty.amt
                        currentGroup!.groupList[index].unit = newQty.unit
                        currentGroup!.groupList[index].measure = newQty.unit.str
                    }
                    changed = true
                    break
                }
            }
            if (!changed) {
                currentGroup!.groupList.append(ingredient)
            }
        }
        
        updateGroupDB()
    }
    
    func deleteIngredientFromGroupList(ingredient: Ingredient) {
        print("deleteIngredientFromGroupList called")
        var gl = currentGroup!.groupList
        
        for index in 0 ..< gl.count {
            if (gl[index].id == ingredient.id) {
                gl.remove(at: index)
                break
            }
        }
        
        currentGroup!.groupList = gl
        updateGroupDB()
    }
    
    func incrementQuantity(ingredient: Ingredient, amt: Int) {
        switch amt {
        case 0:
            print("single tap")
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity += 0.01
        case 1:
            print("double tap")
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity += 0.1
        default:
            print("long press")
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity += 1.0
        }
        
        updateDB()
    }
    
    func decrementQuantity(ingredient: Ingredient, amt: Int) {
        switch amt {
        case 0:
            print("single tap")
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity -= 0.01
        case 1:
            print("double tap")
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity -= 0.1
        default:
            print("long press")
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!].quantity -= 1.0
        }
        
        updateDB()
    }
    
    func incrementQuantityPantry(ingredient: Ingredient, amt: Int) {
        switch amt {
        case 0:
            print("single tap")
            currentUser!.pantryList[currentUser!.pantryList.firstIndex(of: ingredient)!].quantity += 0.01
        case 1:
            print("double tap")
            currentUser!.pantryList[currentUser!.pantryList.firstIndex(of: ingredient)!].quantity += 0.1
        default:
            print("long press")
            currentUser!.pantryList[currentUser!.pantryList.firstIndex(of: ingredient)!].quantity += 1.0
        }
        
        updateDB()
    }
    
    func decrementQuantityPantry(ingredient: Ingredient, amt: Int) {
        switch amt {
        case 0:
            print("single tap")
            currentUser!.pantryList[currentUser!.pantryList.firstIndex(of: ingredient)!].quantity -= 0.01
        case 1:
            print("double tap")
            currentUser!.pantryList[currentUser!.pantryList.firstIndex(of: ingredient)!].quantity -= 0.1
        default:
            print("long press")
            currentUser!.pantryList[currentUser!.pantryList.firstIndex(of: ingredient)!].quantity -= 1.0
        }
        
        updateDB()
    }
    
    func incrementQuantityGroup(ingredient: Ingredient, amt: Int) {
        switch amt {
            case 0:
                print("single tap")
                currentGroup!.groupList[currentGroup!.groupList.firstIndex(of: ingredient)!].quantity += 0.01
            case 1:
                print("double tap")
                currentGroup!.groupList[currentGroup!.groupList.firstIndex(of: ingredient)!].quantity += 0.1
            default:
                print("long press")
                currentGroup!.groupList[currentGroup!.groupList.firstIndex(of: ingredient)!].quantity += 1.0
        }
        
        updateGroupDB()
    }
    
    func decrementQuantityGroup(ingredient: Ingredient, amt: Int) {
        switch amt {
            case 0:
                print("single tap")
                currentGroup!.groupList[currentGroup!.groupList.firstIndex(of: ingredient)!].quantity -= 0.01
            case 1:
                print("double tap")
                currentGroup!.groupList[currentGroup!.groupList.firstIndex(of: ingredient)!].quantity -= 0.1
            default:
                print("long press")
                currentGroup!.groupList[currentGroup!.groupList.firstIndex(of: ingredient)!].quantity -= 1.0
        }
        
        updateGroupDB()
    }
    
    func changeIngredientUnit(ingredient: Ingredient, newUnit: CustomUnit) {
        // change measure here too
        let index = currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ingredient)!
        
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].unit = newUnit
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].measure = newUnit.str
        currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList[index].qty = Quantity(amt: ingredient.quantity, unit: newUnit)
        
        updateDB()
    }
    
    func changeIngredientUnitPantry(ingredient: Ingredient, newUnit: CustomUnit) {
        let index = currentUser!.pantryList.firstIndex(of: ingredient)!
        
        currentUser!.pantryList[index].unit = newUnit
        currentUser!.pantryList[index].measure = newUnit.str
        currentUser!.pantryList[index].qty = Quantity(amt: ingredient.quantity, unit: newUnit)
        
        updateDB()
    }
    
    func changeIngredientUnitGroup(ingredient: Ingredient, newUnit: CustomUnit) {
        let index = currentGroup!.groupList.firstIndex(of: ingredient)!
        
        currentGroup!.groupList[index].unit = newUnit
        currentGroup!.groupList[index].measure = newUnit.str
        currentGroup!.groupList[index].qty = Quantity(amt: ingredient.quantity, unit: newUnit)
        
        updateGroupDB()
    }
    
    func finishedShopping(checkedOffList: [Ingredient]) {
        for ing in checkedOffList {
            currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.remove(at: currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].personalList.firstIndex(of: ing)!)
            currentUser!.pantryList.append(ing)
        }
    }
    
    func finishedShoppingGroup(checkedOffList: [Ingredient]) {
        for ing in checkedOffList {
            currentGroup!.groupList.remove(at: currentGroup!.groupList.firstIndex(of: ing)!)
        }
    }
    
    // Group Methods
    
    func getGroup(groupID: String) {
        liveGroupListener = db.collection("groups").document(groupID)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                let result = Result {
                    try document.data(as: GroupDB.self)
                }
                switch result {
                    case .success(let group):
                        if let group = group {
                            self.convertGroupDBToGroup(groupDB: group)
                        } else {
                            // let user know eventually
                            print("document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding group: \(error)")
                }
            }
    }
    
    func convertUserToUserGroup(user: User) -> UserGroup {
        return UserGroup(id: user.id, email: user.email, name: user.name, groupID: user.groupID)
    }
    
    func convertGroupToGroupDB(group: Group) -> GroupDB {
        let groupList = convertIngsToApi(ings: group.groupList)
        return GroupDB(groupID: group.groupID, groupList: groupList, leaderID: group.leaderID, members: group.members)
    }
    
    func convertGroupDBToGroup(groupDB: GroupDB) {
        let groupList = convertApitoIngs(ingsApi: groupDB.groupList)
        currentGroup = Group(groupID: groupDB.groupID!, groupList: groupList, leaderID: groupDB.leaderID, members: groupDB.members)
        hasGroup = true
        updateGroupDB()
    }
    
    func createGroup() {
        let leaderID = currentUser!.id
        let groupID = UUID().uuidString
        currentUser!.groupID = groupID
        
        var members = [[String: Any]]()
        members.append(
            [
                "id": currentUser!.id,
                "name": currentUser!.name,
                "email": currentUser!.email,
                "groupID": currentUser!.groupID
            ]
        )
        
        let g : [String: Any] = [
            "groupList": [],
            "leaderID": leaderID,
            "members": members
        ]
        
        db.collection("groups").document(groupID).setData(g) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.updateDB()
                self.getGroup(groupID: groupID)
            }
        }
    }
    
    func joinGroup(groupID: String) {
        let docRef = db.collection("groups").document(groupID)
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: GroupDB.self)
            }
            switch result {
                case .success(let group):
                    if var group = group {
                        self.currentUser!.groupID = groupID
                        group.members.append(self.convertUserToUserGroup(user: self.currentUser!))
                        self.convertGroupDBToGroup(groupDB: group)
                        self.updateGroupDB()
                        self.updateDB()
                        self.getGroup(groupID: groupID)
                    } else {
                        // let user know eventually
                        print("document does not exist")
                    }
                case .failure(let error):
                    print("Error decoding group: \(error)")
            }
        }
    }
    
    func updateGroupDB() {
        print("Update Group DB")
        let groupdb : GroupDB = self.convertGroupToGroupDB(group: currentGroup!)

        do {
            try self.db.collection("groups").document(groupdb.groupID!).setData(from: groupdb)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }

        self.objectWillChange.send()
    }
    
    func leaveGroup() {
        print("in leave group")
        if (currentUser!.id == currentGroup!.leaderID) {
            removeGroup(group: currentGroup!)
        } else {
            for (index, mem) in currentGroup!.members.enumerated() {
                if (currentUser!.id == mem.id) {
                    currentGroup!.members.remove(at: index)
                    liveGroupListener!.remove()
                    updateGroupDB()
                    break
                }
            }
        }
        currentUser!.groupID = ""
        hasGroup = false
        updateDB()
        print("leave group, hasGroup: \(hasGroup)")
    }
    
    func removeGroup(group: Group) {
        db.collection("groups").document(group.groupID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document removed!")
            }
        }
        
        for mem in group.members {
            print("member: \(mem)")
            let memRef = db.collection("accounts").document(mem.id)
            memRef.updateData([
                "groupID": ""
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    func removeMemberFromGroup(memID: String) {
        for (index, mem) in currentGroup!.members.enumerated() {
            if memID == mem.id {
                currentGroup!.members.remove(at: index)
                break
            }
        }
        let memRef = db.collection("accounts").document(memID)
        memRef.updateData([
            "groupID": ""
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        updateGroupDB()
    }
    
    // Sunday Logic
    
    func checkForWUDRefresh() {
        let today = Date()
        let refreshDate = getNextSunday(date: currentUser!.weeklyUserData[currentUser!.weeklyUserData.count - 1].startDate, index: 0)
        if (refreshDate == today) {
            let recipesOfWeek : [DaysOfWeek:[Recipe]] = [
                DaysOfWeek.Unassigned:[],
                DaysOfWeek.Sunday:[],
                DaysOfWeek.Monday:[],
                DaysOfWeek.Tuesday:[],
                DaysOfWeek.Wednesday:[],
                DaysOfWeek.Thursday:[],
                DaysOfWeek.Friday:[],
                DaysOfWeek.Saturday:[]
            ]
            
            let weeklyUserData = WeeklyUserData(startDate: today, personalList: [], recipesOfWeek: recipesOfWeek)
            
            currentUser!.weeklyUserData.append(weeklyUserData)
            updateDB()
        } else if (refreshDate < today) {
            let recipesOfWeek : [DaysOfWeek:[Recipe]] = [
                DaysOfWeek.Unassigned:[],
                DaysOfWeek.Sunday:[],
                DaysOfWeek.Monday:[],
                DaysOfWeek.Tuesday:[],
                DaysOfWeek.Wednesday:[],
                DaysOfWeek.Thursday:[],
                DaysOfWeek.Friday:[],
                DaysOfWeek.Saturday:[]
            ]
            
            let weeklyUserData = WeeklyUserData(startDate: self.getPrevSunday(date: today, index: 0), personalList: [], recipesOfWeek: recipesOfWeek)
            
            currentUser!.weeklyUserData.append(weeklyUserData)
            updateDB()
        } else {
            return
        }
    }
    
    
    
    func setInitalStartDate() -> Date {
        let today = Date()
        if (isSunday(date: today)) {
            return today
        } else {
            return getPrevSunday(date: today, index: 0)
        }
    }
    
    func isSunday(date: Date) -> Bool {
        let cal = Calendar(identifier: .gregorian)
        let dayOfWeek = cal.component(.weekday, from: date)
        
        if (dayOfWeek == 1) {
            return true
        } else {
            return false
        }
    }
    
    func getPrevSunday(date: Date, index: Int) -> Date {
        let cal = Calendar(identifier: .gregorian)
        let dayOfWeek = cal.component(.weekday, from: date)
        
        if dayOfWeek == 1 && index > 0 {
            return date
        } else {
            return getPrevSunday(date: date - 86400, index: index + 1)
        }
    }
    
    func getNextSunday(date: Date, index: Int) -> Date {
        let cal = Calendar(identifier: .gregorian)
        let dayOfWeek = cal.component(.weekday, from: date)
        
        if dayOfWeek == 1 && index > 0 {
            return date
        } else {
            return getNextSunday(date: date + 86400, index: index + 1)
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
    
    func searchPantryList(text: String) -> [Ingredient] {
        let lowerText = text.lowercased()
        var searchedIngredient: [Ingredient] = []
        for ingredient in currentUser!.pantryList {
            print(ingredient.food)
            if ingredient.food.lowercased().contains(lowerText) {
                searchedIngredient.append(ingredient)
            }
        }
        return searchedIngredient
    }
    
    func searchGroupList(text: String) -> [Ingredient] {
        let lowerText = text.lowercased()
        var searchedIngredient: [Ingredient] = []
        for ingredient in currentGroup!.groupList {
            print(ingredient.food)
            if ingredient.food.lowercased().contains(lowerText) {
                searchedIngredient.append(ingredient)
            }
        }
        return searchedIngredient
    }
}
