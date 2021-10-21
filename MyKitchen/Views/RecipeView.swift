//
//  RecipeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/21/21.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    var body: some View {
        
//        List(Recipe, id: \.name) {
//            Recipe in
//            RecipeCardView(recipe: Recipe)
//        }
        List(recipes){ recipe in
            RecipeCardView(recipe: recipe)
        }
        RecipeCardView(recipe: recipe)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var recipe = Recipe.data[1]
    static var previews: some View {
        RecipeView(recipe: recipe)
    }
}
