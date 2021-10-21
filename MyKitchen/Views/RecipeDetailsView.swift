//
//  RecipeDetailsView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    var body: some View {
        Text(recipe.name)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var recipe = Recipe.data[0]
    static var previews: some View {
        RecipeDetailsView(recipe: recipe)
    }
}
