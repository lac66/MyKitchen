//
//  ItemView.swift
//  MyKitchen
//
//  Created by Akshay on 11/3/21.
//

import SwiftUI

let colNavAppearance = UINavigationBarAppearance()

struct ItemView: View {
    let ingredient: [Ingredient]
    
    init(ingredientList: [Ingredient]) {
        ingredient = ingredientList
        
        colNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = colNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = colNavAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack (spacing: 10) {
                        ForEach(ingredient, id: \.id) { ingredient in
                            NavigationLink(
                                destination: IngredientEditCardView(ingredient:ingredient),
                                label: {
                                    IngredientEditCardView(ingredient: ingredient)
                                })
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var ingredient = Ingredient.data
    static var previews: some View {
        ItemView(ingredientList: ingredient)
    }
}

