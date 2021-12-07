//
//  RecipeCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI
import ToastViewSwift

struct RecipeCardView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage?
    
    @State var recipe: Recipe
    let heartImg: String
    
    init(recipe: Recipe, withURL url: String?, heartImg: String) {
        self.recipe = recipe
        self.heartImg = heartImg
        if (url != nil) {
            imageLoader = ImageLoader(urlString: url!)
        } else {
            imageLoader = ImageLoader(urlString: "")
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                // need to load image from url
                if (image != nil) {
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 65, height: 65)
                        .cornerRadius(6)
                } else {
                    Text("No image available")
                        .frame(width: 65, height: 65)
                        .cornerRadius(6)
                }
            }
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
                self.recipe.img = self.image
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding(.bottom, 1)
                
                let yieldText: String = String(format: "%.1f", recipe.yield)
                Text("Yield: \(yieldText)")
                    .font(.system(size: 16, weight: .regular, design: .default))
//                Text(recipe.difficulty)
//                    .font(.system(size: 16, weight: .regular, design: .default))
            }
            .padding(.leading, 15)
            
            Spacer()
            
            VStack (spacing: 4) {
                Spacer()
                
                Button {
                    // saved to favorites
                    if (heartImg == "heart") {
                        fbInterface.saveRecipe(recipe: recipe)
                        let toast = Toast.text("Recipe Saved")
                        toast.show()
                    } else {
                        fbInterface.unsaveRecipe(recipe: recipe)
                        let toast = Toast.text("Recipe Unsaved")
                        toast.show()
                    }
                } label: {
                    Image(systemName: heartImg)
                        .frame(width: 20, height: 20)
                        .background(Color("Camel"))
                        .cornerRadius(4)
                }
                
                Button {
                    fbInterface.addRecipeToWeeklyData(recipe: recipe)
                    let toast = Toast.text("Recipe added to Personal List")
                    toast.show()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 20, height: 20)
                        .background(Color("Camel"))
                        .cornerRadius(4)
                }
            }
            .padding(.trailing, 10)
            .padding(.bottom, 8)
        }
        .frame(width: 350, height: 90)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(8)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static let recipe = Recipe(id: "id", name: "name", imgUrl: "imgUrl", sourceUrl: "sourceUrl", yield: 1, ingString: ["ingArr"], ingredients: [Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/627/627582f390a350d98c367f89c3a943fe.jpg")], calories: 1.0, cuisineType: ["cuisineType"], mealType: ["mealType"], recipeInstructions: nil)
    static var previews: some View {
        RecipeCardView(recipe: recipe, withURL: recipe.imgUrl!, heartImg: "heart")
            .previewLayout(.fixed(width: 350, height: 90))
    }
}
