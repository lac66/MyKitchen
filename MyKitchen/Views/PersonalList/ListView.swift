//
//  ListView.swift
//  MyKitchen
//
//  Created by Akshay on 11/4/21.
//

import SwiftUI

let listNavAppearance = UINavigationBarAppearance()

struct ListView: View {
    let ingredient: [Ingredient]
    
    init(ingredientList: [Ingredient]) {
        ingredient = ingredientList
        
        listNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = colNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = listNavAppearance
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

struct ListView_Previews: PreviewProvider {
    static var ingredient = Ingredient.data
    static var previews: some View {
        ListView(ingredientList: ingredient)
    }
}


