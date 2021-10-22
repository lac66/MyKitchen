//
//  RecipeCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                Image("food")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .cornerRadius(6)
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.bottom, 1)
                Text(recipe.cookTime)
                    .font(.system(size: 16, weight: .regular, design: .default))
                Text(recipe.difficulty)
                    .font(.system(size: 16, weight: .regular, design: .default))
            }
            .padding(.leading, 15)
            
            Spacer()
            
            VStack () {
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("Camel"))
                        .cornerRadius(4)
                    
                    Image(systemName: "heart.fill")
                }
                ZStack {
                    Rectangle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("Camel"))
                        .cornerRadius(4)
                    
                    Image(systemName: "plus")
                }
            }
            .padding(.trailing, 10)
            .padding(.bottom, 10)
        }
        .frame(width: 350, height: 90)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var recipe = Recipe.data[0]
    static var previews: some View {
        RecipeCardView(recipe: recipe)
            .background(Color.red)
            .previewLayout(.fixed(width: 350, height: 90))
    }
}
