//
//  RecipeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/21/21.
//

import SwiftUI

struct RecipeView: View {
    let recipes: [Recipe]
    var body: some View {
        VStack {
            NavigationView {
                List (recipes) { recipe in
                    NavigationLink(
                        destination: RecipeDetailsView(recipe: recipe)) {
                        RecipeCardView(recipe: recipe)
                    }
                    .background(Color(red: 0.47058823529411764, green: 0.6313725490196078, blue: 0.7333333333333333))
                }
                .navigationTitle("Recipes")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var recipes = Recipe.data
    static var previews: some View {
        RecipeView(recipes: recipes)
    }
}
