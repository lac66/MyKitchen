//
//  PlanningView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

// planning page
struct PlanningView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
    @State var isExploring = true
    @State var searchText = ""
    @State var typingCheck: DispatchWorkItem?
    
    init() {
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
                    // stack for title, searchbar, and buttons
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Planning")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
        
                        Searchbar(placeholder: "Search here", isForRecipes: true, text: $searchText)
                            .onChange(of: searchText) { newValue in
                                if (isExploring) {
                                    if (typingCheck != nil) {
                                        typingCheck!.cancel()
                                        typingCheck = nil
                                    }
                                    
                                    typingCheck = DispatchWorkItem {
                                        print("search")
                                        searchApi()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: typingCheck!)
                                }
                            }
                            .foregroundColor(Color("MintCream"))
                            .frame(width: 350)
                        
                        HStack (spacing: 0) {
                            Button("Saved") {
                                print("saved")
                                isExploring = false
                                searchText = ""
                            }
                            .frame(width: 160, height: 30)
                            .background(isExploring ? Color("Camel") : Color("CamelDark"))
                            
                            Button("Explore") {
                                print("explore")
                                isExploring = true
                                searchText = ""
                            }
                            .frame(width: 160, height: 30)
                            .background(isExploring ? Color("CamelDark") : Color("Camel"))
                            
                            NavigationLink(
                                destination: AddRecipeView().environmentObject(eInterface),
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
                    
                    // stack for recipe information
                    ScrollView {
                        VStack (spacing: 10) {
                            if isExploring {
                                if (eInterface.recipes.count == 0) {
                                    Text("Enter a recipe above to begin exploring")
                                        .foregroundColor(Color("MintCream"))
                                } else {
                                    ForEach(eInterface.recipes, id: \.id) { recipe in
                                        NavigationLink(
                                            destination: RecipeDetailsView(recipe: recipe, isPlanning: true),
                                            label: {
                                                if (fbInterface.currentUser!.savedRecipes.contains(recipe)) {
                                                    RecipeCardView(recipe: recipe, withURL: recipe.imgUrl, heartImg: "heart.fill")
                                                } else {
                                                    RecipeCardView(recipe: recipe, withURL: recipe.imgUrl, heartImg: "heart")
                                                }
                                            })
                                    }
                                }
                            } else {
                                if (fbInterface.currentUser!.savedRecipes.count == 0) {
                                    Text("No saved recipes.")
                                        .foregroundColor(Color("MintCream"))
                                } else if !searchText.isEmpty {
                                    ForEach(fbInterface.searchSavedRecipes(text: searchText).sorted(by: { $0.name.lowercased() < $1.name.lowercased() }), id: \.id) { recipe in
                                        if recipe.recipeInstructions != nil {
                                            NavigationLink(
                                                destination: RecipeDetailsView(recipe: recipe, isPlanning: true),
                                                label: {
                                                    RecipeCardView(recipe: recipe, withURL: recipe.imgUrl, heartImg: "trash")
                                                })
                                        } else {
                                            NavigationLink(
                                                destination: RecipeDetailsView(recipe: recipe, isPlanning: true),
                                                label: {
                                                    RecipeCardView(recipe: recipe, withURL: recipe.imgUrl, heartImg: "heart.fill")
                                                })
                                        }
                                    }
                                } else {
                                    ForEach(fbInterface.currentUser!.savedRecipes.sorted(by: { $0.name.lowercased() < $1.name.lowercased() }), id: \.id) { recipe in
                                        if recipe.recipeInstructions != nil {
                                            NavigationLink(
                                                destination: RecipeDetailsView(recipe: recipe, isPlanning: true),
                                                label: {
                                                    RecipeCardView(recipe: recipe, withURL: recipe.imgUrl, heartImg: "trash")
                                                })
                                        } else {
                                            NavigationLink(
                                                destination: RecipeDetailsView(recipe: recipe, isPlanning: true),
                                                label: {
                                                    RecipeCardView(recipe: recipe, withURL: recipe.imgUrl, heartImg: "heart.fill")
                                                })
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    // function to call api
    func searchApi() {
        eInterface.searchWithApi(text: searchText, isForRecipes: true)
    }
}

struct PlanningView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningView()
    }
}
