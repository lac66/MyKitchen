//
//  MealViewer.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//

import SwiftUI

struct MealViewer: View {
    
    let recipes: [Recipe]
    
    init(recipeList: [Recipe]) {
        recipes = recipeList
        
        coloredNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    var body: some View {
        // entire page should be UICollectionView where you can drag from top HStack to bottom V Stack
        VStack {
            Text("Meal Viewer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ForEach(recipes, id: \.id) { recipe in
                        MealViewerCardView(recipe: recipe)
                    }
                }
                
            }
            Spacer()

        }
        
    }
    
}


struct MealViewer_Previews: PreviewProvider {
    static var recipes = Recipe.data
    static var previews: some View {
        MealViewer(recipeList: recipes)
    }
}
