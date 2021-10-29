//
//  PlanningView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

let navAppearance = UINavigationBarAppearance()

struct PlanningView: View {
    let recipes: [Recipe]
    
    @State var searchText = ""
    
    init(recipeList: [Recipe]) {
        recipes = recipeList
        
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "MintCream") as Any]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack (alignment: .leading) {
                        Text("Planning")
                            .font(.system(size: 32, weight: .bold, design: .default))
        
                        Searchbar(placeholder: Text("Search here"), text: $searchText)
                            .foregroundColor(Color("MintCream"))
                        
                        HStack (spacing: 0) {
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
                        }
                        .cornerRadius(8)
                    }
                    .foregroundColor(Color("MintCream"))
                    
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

struct PlanningView_Previews: PreviewProvider {
    static var recipes = Recipe.data
    static var previews: some View {
        PlanningView(recipeList: recipes)
    }
}
