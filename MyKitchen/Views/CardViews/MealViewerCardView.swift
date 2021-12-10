//
//  MealViewerCard.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//
import SwiftUI
import ToastViewSwift

// card for mealviewer recipes
struct MealViewerCardView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    let recipe: Recipe
    @State var selectedDay: DaysOfWeek
    
    init(recipe: Recipe, withURL url: String?, selectedDay: DaysOfWeek) {
        self.recipe = recipe
        self.selectedDay = selectedDay
        
        if (url == nil) {
            imageLoader = ImageLoader(urlString: "")
        } else {
            imageLoader = ImageLoader(urlString: url!)
        }
    }
    
    var body: some View {
        
        VStack(spacing: 5) {
            HStack {
                Text(recipe.name)
                    .font(.system(size: 24, design: .default))
                    .foregroundColor(Color("MintCream"))
                Spacer()
                
                Button(action: {/*do something*/}, label: {
                    Menu {
                        ForEach(0 ..< DaysOfWeek.allCases.count) { index in
                            Button(DaysOfWeek.allCases[index].str, action: {changeDay(day: DaysOfWeek.allCases[index])})
                            
                        }
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                })  
                Button{
                    let toast = Toast.text("Recipe Deleted")
                    toast.show()
                    deleteRecipe()
                } label: {
                    Image(systemName: "trash")
                        .frame(width: 20, height: 20)
                        .background(Color("Camel"))
                        .cornerRadius(4)
                }
            }
            .frame(width: 300)
            .padding(.top, 5)
            
            if (recipe.imgUrl != nil) {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: recipe.imgUrl!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300, height: 160)
                    .cornerRadius(8)
                    .padding(.bottom, 5)
                } else {
                    // Fallback on earlier versions
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 300, height: 160)
                        .cornerRadius(8)
                        .padding(.bottom, 5)
                        .onReceive(imageLoader.didChange) { data in
                            self.image = UIImage(data: data) ?? UIImage()
                        }
                }
            } else {
                Text("No Image Found")
                    .frame(width: 300, height: 160)
                    .background(Color("Camel"))
                    .foregroundColor(Color("MintCream"))
                    .cornerRadius(8)
                    .padding(.bottom, 5)
            }
        }
        .frame(width: 325)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(8)
    }
    
    // function to change day for recipe
    func changeDay(day: DaysOfWeek) {
        print("Entered change Day")
        fbInterface.updateUserRecipesOfWeek(initialDay: selectedDay, newDay: day, recipe: recipe)
    }
    
    // function to delete recipe
    func deleteRecipe() {
        fbInterface.deleteRecipeFromUserRecipesOfWeek(day: selectedDay, recipe: recipe)
    }
}

struct MealViewerCardView_Previews: PreviewProvider {
    //    static var recipe = Recipe.data[0]
    static let recipe = Recipe(id: "id", name: "name", imgUrl: "imgUrl", sourceUrl: "sourceUrl", yield: 1, ingString: ["ingArr"], ingredients: [Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/627/627582f390a350d98c367f89c3a943fe.jpg")], calories: 1.0, cuisineType: ["cuisineType"], mealType: ["mealType"], recipeInstructions: nil)
    static var previews: some View {
        MealViewerCardView(recipe: recipe, withURL: recipe.imgUrl, selectedDay: .Unassigned)
            .background(Color.white)
            .previewLayout(.fixed(width: 325, height: 175))
    }
}

// onChange binding for state vars
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
            })
    }
}

