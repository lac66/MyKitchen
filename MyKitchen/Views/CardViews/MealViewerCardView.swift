//
//  MealViewerCard.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//
import SwiftUI

struct MealViewerCardView: View {
    let recipe: Recipe
    var body: some View {
        
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.system(size: 24, design: .default))
                    .foregroundColor(Color("OxfordBlue"))
                    .padding(.bottom, 1)
                Spacer()
                /*
                NavigationLink(
                    EditRecipeView()){
                        ZStack {
                            Rectangle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("Camel"))
                                .cornerRadius(4)
                            
                            Image(systemName: "pencil")
                        }
                    }
                 */

                NavigationLink(
                    destination: MealDaySelection()){
                        ZStack {
                            Rectangle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("Camel"))
                                .cornerRadius(4)
                            
                            Image(systemName: "plus")
                        }
                    }
            }
            .padding(.horizontal, 10.0)
            Image("food")
                .resizable()
                .frame(width: 350, height: 140)
                .cornerRadius(6)
                .padding(.bottom, 5.0)
                .padding(.top, -10.0)
        }
        .frame(width: 400, height: 175)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(15)
    }
}

struct MealViewerCardView_Previews: PreviewProvider {
    static let recipe = Recipe(id: "id", name: "name", imgUrl: "imgUrl", sourceUrl: "sourceUrl", yield: 1, ingString: ["ingArr"], ingredients: [Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/627/627582f390a350d98c367f89c3a943fe.jpg")], calories: 1.0, cuisineType: ["cuisineType"], mealType: ["mealType"])
    static var previews: some View {
        MealViewerCardView(recipe: recipe)
            .background(Color.white)
            .previewLayout(.fixed(width: 400, height: 175))
    }
}
