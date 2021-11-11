//
//  PlanningView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

struct PlanningView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
//    var recipes: [Recipe]
    
    @State var searchText = ""
    
    init() {
//        recipes = recipeList
        
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
        
                        Searchbar(placeholder: Text("Search here"), isForRecipes: true, text: $searchText)
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
                            ForEach(eInterface.recipes, id: \.id) { recipe in
                                NavigationLink(
                                    destination: RecipeDetailsView(recipe: recipe),
                                    label: {
                                        RecipeCardView(recipe: recipe, withURL: recipe.imgUrl)
                                    })
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct PlanningView_Previews: PreviewProvider {
//    static var recipes = Recipe.data
    static var previews: some View {
        PlanningView()
    }
}
