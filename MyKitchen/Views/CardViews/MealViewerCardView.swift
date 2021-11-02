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
    static var recipe = Recipe.data[0]
    static var previews: some View {
        MealViewerCardView(recipe: recipe)
            .background(Color.white)
            .previewLayout(.fixed(width: 400, height: 175))
    }
}
