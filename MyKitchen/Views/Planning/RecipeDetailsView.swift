//
//  RecipeDetailsView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct RecipeDetailsView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    let recipe: Recipe
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color("OxfordBlue").ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack (alignment: .leading) {
                        Text(recipe.name)
                            .navigationBarTitle("Recipe Details", displayMode: .inline)
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .padding(.leading, 25)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 350)
                                .foregroundColor(Color("Camel"))
                                .cornerRadius(30)
                            
                            if (recipe.img != nil) {
                                Image(uiImage: recipe.img!)
                                    .resizable()
                                    .frame(width: 325, height: 325)
                                    .cornerRadius(25)
                            } else {
                                // show default image
                                Image(uiImage: UIImage())
                            }
                        }
                        
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .frame(width: 350)
                                .foregroundColor(Color("AirBlue"))
                                .cornerRadius(30)
                            
                            VStack (alignment: .leading) {
                                Text("Ingredients")
                                    .padding(.bottom)
                                    .font(.system(size: 24, weight: .semibold, design: .default))
                                
                                ForEach(recipe.ingredients, id: \.id) { ingredient in
                                    Text(ingredient.text)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(1)
                                        .padding(.leading)
//                                        .padding(.trailing)
                                }
                            }
                            .frame(width: 300)
                            .padding(12)
                            .padding(.leading, 12)
                        }
                        
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .frame(width: 350)
                                .foregroundColor(Color("AirBlue"))
                                .cornerRadius(30)
                            
                            VStack (alignment: .leading) {
                                Text("Instructions")
                                    .padding(.bottom)
                                    .font(.system(size: 24, weight: .semibold, design: .default))
                                
                                Link( "Click Here", destination: URL(string: recipe.sourceUrl)!)
                                    .padding(1)
                                    .padding(.leading)
                            }
                            .frame(width: 300)
                            .padding(12)
                            .padding(.leading, 12)
                        }
                    }
                    .foregroundColor(Color("MintCream"))
                }
                
                VStack {
                    Button("Add to List") {
                        // add to personal List
                        fbInterface.addRecipe(recipe: recipe)
                    }
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color("MintCream"))
                    .font(.system(size: 30, weight: .black, design: .monospaced))
                    .background(Color("Camel"))
                    .cornerRadius(24)
                }
                .padding(.bottom, 10)
            }
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static let recipe = Recipe(id: "id", name: "name", imgUrl: "imgUrl", sourceUrl: "sourceUrl", yield: 1, ingString: ["ingArr"], ingredients: [Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/627/627582f390a350d98c367f89c3a943fe.jpg")], calories: 1.0, cuisineType: ["cuisineType"], mealType: ["mealType"])
    static var previews: some View {
        RecipeDetailsView(recipe: recipe)
    }
}
