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
        VStack() {
            Text(recipe.name)
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.bottom, 1)
            Text(recipe.cookTime)
                .font(.system(size: 16, weight: .regular, design: .default))
            Text(recipe.difficulty)
                .font(.system(size: 16, weight: .regular, design: .default))
//                .padding(-10)
        }
        .frame(width: 300, height: 80)
        .background(Color(red: 0.47058823529411764, green: 0.6313725490196078, blue: 0.7333333333333333))
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var recipe = Recipe.data[0]
    static var previews: some View {
        RecipeCardView(recipe: recipe)
            .background(Color.red)
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
