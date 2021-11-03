//
//  PantryView.swift
//  MyKitchen
//
//  Created by Akshay 11/3/21.
//

import SwiftUI

let pannavAppearance = UINavigationBarAppearance()

struct PantryView: View {
    let ingredient: [Ingredient]
    
    @State var searchText = ""
    
    init(ingredientList: [Ingredient]) {
        ingredient = ingredientList
        
        pannavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        pannavAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "MintCream") as Any]
        
        UINavigationBar.appearance().standardAppearance = pannavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = pannavAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack (alignment: .leading) {
                        Text("Pantry List")
                            .font(.system(size: 32, weight: .bold, design: .default))
        
                        Searchbar(placeholder: Text("Search here"), text: $searchText)
                            .foregroundColor(Color("MintCream"))
                        
                        /*HStack (spacing: 0) {
                            Button("Saved") {
                                print("saved")
                            }
                            .frame(width: 160, height: 30)
                            .background(Color("Camel"))
                            
                            Button("Explore") {
                                print("explore")
                            }
                            .frame(width: 160, height: 30)
                            .background(Color("Camel"))
                            
                            NavigationLink(
                                destination: AddRecipeView(),
                                label: {
                                    Image(systemName: "plus")
                                        .frame(width: 30, height: 30)
                                        .background(Color("Camel"))
                                }
                            )
                        }*/
                        .cornerRadius(8)
                    }
                    .foregroundColor(Color("MintCream"))
                    
                    ScrollView {
                        VStack (spacing: 10) {
                            ForEach(ingredient, id: \.id) { ingredient in
                                NavigationLink(
                                    destination: ItemDetailView(ingredient: ingredient),
                                    label: {
                                        IngredientEditCardView(ingredient: ingredient)
                                    })
                            }
                        }
                    }
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem (placement: .principal) {
//                                VStack {
//                                    Text("Planning").font(.headline)
//
//                                    ZStack {
//                                        HStack {
//                                            TextField("Search here", text: $searchText)
//                                                .padding()
//                                        }
//                                        .frame(width: 350, height: 30)
//                                        .background(Color("MintCream"))
//                                        .cornerRadius(20)
//                                    }
//                                }
//                                .padding(.top, 30)
//                                .foregroundColor(Color("MintCream"))
//                            }
//                        }
                }
                .navigationBarHidden(true)
//                .padding(.top, 30)
                
//                ScrollView {
//                    VStack (spacing: 10) {
//                        ForEach(recipes, id: \.id) { recipe in
//                            NavigationLink(
//                                destination: RecipeDetailsView(recipe: recipe),
//                                label: {
//                                    RecipeCardView(recipe: recipe)
//                                })
//                        }
//                    }
//                }
//                .padding(.top)
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem (placement: .principal) {
//                        VStack {
//                            Text("Planning").font(.headline)
//
//                            ZStack {
//                                HStack {
//                                    TextField("Search here", text: $searchText)
//                                }
//                                .frame(height: 30)
//                                .background(Color("MintCream"))
//                            }
//
//                            HStack (spacing: 0) {
//                                Button("Saved") {
//                                    print("saved")
//                                }
//                                .frame(width: 160, height: 30)
//                                .background(Color("Camel"))
//
//                                Button("Explore") {
//                                    print("saved")
//                                }
//                                .frame(width: 160, height: 30)
//                                .background(Color("Camel"))
//
//                                Button {
//
//                                } label: {
//                                    Image(systemName: "plus")
//                                        .frame(width: 30, height: 30)
//                                        .background(Color("Camel"))
//                                }
//                            }
//                            .cornerRadius(8)
//                        }
//                        .foregroundColor(Color("MintCream"))
//                    }
//                }
            }
        }
    }
}

struct PantryView_Previews: PreviewProvider {
    static var ingredient = Ingredient.data
    static var previews: some View {
        PantryView(ingredientList: ingredient)
    }
}