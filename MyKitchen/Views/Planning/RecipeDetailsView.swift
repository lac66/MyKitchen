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
                    VStack (alignment: .center) {
                        Text(recipe.name)
                            .navigationBarTitle("Recipe Details", displayMode: .inline)
                            .frame(width: 350)
                            .font(.system(size: 32, weight: .bold, design: .default))
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 350)
                                .foregroundColor(Color("Camel"))
                                .cornerRadius(20)
                            
                            if recipe.imgUrl != nil {
                                if #available(iOS 15.0, *) {
                                    AsyncImage(url: URL(string: recipe.imgUrl!)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 325, height: 325)
                                    .cornerRadius(20)
                                } else {
                                    // Fallback on earlier versions
                                    
                                    if (recipe.img != nil) {
                                        Image(uiImage: recipe.img!)
                                            .resizable()
                                            .frame(width: 325, height: 325)
                                            .cornerRadius(20)
                                    } else {
                                        Text("No Image Found")
                                            .frame(width: 325, height: 325)
                                            .cornerRadius(20)
                                    }
                                }
                            } else {
                                Text("No Image Found")
                                    .frame(width: 325, height: 325)
                                    .cornerRadius(20)
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 350)
                                .foregroundColor(Color("AirBlue"))
                                .cornerRadius(20)
                            
                            HStack {
                                let yieldText: String = String(format: "%.1f", recipe.yield)
                                Text("Yield:\t")
                                    .font(.system(size: 24, weight: .semibold, design: .default))
                                Text(yieldText)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                            }
                            .padding()
                        }
                        
                        if recipe.cuisineType != nil {
                            ZStack {
                                Rectangle()
                                    .frame(width: 350)
                                    .foregroundColor(Color("AirBlue"))
                                    .cornerRadius(20)
                                
                                VStack {
                                    Text("Cuisine Type")
                                        .padding(.bottom, 5)
                                        .font(.system(size: 24, weight: .semibold, design: .default))
                                    
                                    ForEach(recipe.cuisineType!, id: \.self) { type in
                                        Text(type.capitalized)
                                    }
                                }
                                .padding(12)
                            }
                        }
                        
                        if recipe.mealType != nil {
                            ZStack {
                                Rectangle()
                                    .frame(width: 350)
                                    .foregroundColor(Color("AirBlue"))
                                    .cornerRadius(20)
                                
                                VStack {
                                    Text("Meal Type")
                                        .padding(.bottom, 5)
                                        .font(.system(size: 24, weight: .semibold, design: .default))
                                    
                                    ForEach(recipe.mealType!, id: \.self) { type in
                                        Text(type.capitalized)
                                    }
                                }
                                .padding(12)
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 350)
                                .foregroundColor(Color("AirBlue"))
                                .cornerRadius(20)
                            
                            VStack {
                                Text("Ingredients")
                                    .padding(.bottom)
                                    .font(.system(size: 24, weight: .semibold, design: .default))
                                VStack (alignment: .leading) {
                                    ForEach(recipe.ingredients, id: \.id) { ingredient in
                                        let amtText: String = String(format: "%.2f", ingredient.quantity)
                                        HStack {
                                            Text(amtText)
                                                .frame(width: 60)
                                            Text(ingredient.unit!.str)
                                                .frame(width: 50, alignment: .leading)
                                            Text(ingredient.food)
                                        }
                                    }
                                }
                            }
                            .frame(width: 300)
                            .padding(12)
                        }
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 350)
                                .foregroundColor(Color("AirBlue"))
                                .cornerRadius(20)
                            
                            VStack (alignment: .center) {
                                Text("Instructions")
                                    .padding(.bottom)
                                    .font(.system(size: 24, weight: .semibold, design: .default))
                                
                                if (recipe.sourceUrl != nil) {
                                    Link( "Click Here", destination: URL(string: recipe.sourceUrl!)!)
                                        .padding(1)
                                } else {
                                    Text(recipe.recipeInstructions!)
                                }
                            }
                            .frame(width: 300)
                            .padding(12)
                        }
                    }
                    .foregroundColor(Color("MintCream"))
                }
                
                VStack {
                    Button("Add to List") {
                        fbInterface.addRecipeToWeeklyData(recipe: recipe)
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
    static let recipe = Recipe(id: "id", name: "name", imgUrl: "imgUrl", sourceUrl: "sourceUrl", yield: 1, ingString: ["ingArr"], ingredients: [Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/627/627582f390a350d98c367f89c3a943fe.jpg")], calories: 1.0, cuisineType: ["cuisineType"], mealType: ["mealType"], recipeInstructions: nil)
    static var previews: some View {
        RecipeDetailsView(recipe: recipe)
    }
}
