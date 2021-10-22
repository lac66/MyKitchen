//
//  RecipeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/21/21.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

struct RecipeView: View {
    let recipes: [Recipe]
    
    init(recipeList: [Recipe]) {
        recipes = recipeList
        
        coloredNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack (spacing: 10) {
                        ForEach(recipes, id: \.id) { recipe in
                            NavigationLink(
                                destination: RecipeDetailsView(recipe: recipe),
                                label: {
                                    RecipeCardView(recipe: recipe)
                                })
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var recipes = Recipe.data
    static var previews: some View {
        RecipeView(recipeList: recipes)
    }
}
