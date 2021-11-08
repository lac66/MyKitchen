//
//  NavBar.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct NavBar: View {
    @EnvironmentObject var eInterface : EdamamInterface
    @EnvironmentObject var fbInterface : FirebaseInterface
    @State var initialIndex = 2
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color("AirBlue"))
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("MintCream"))
    }
    
    var body: some View {
        TabView (selection: $initialIndex) {
            // Text("PlanningView()") can be replaced with view to be showed on click
            //            Text("PlanningView()")
            PlanningView(recipeList: Recipe.getRecipes())
                .tabItem {
                    Label("Planning", systemImage: "magnifyingglass")
                }
                .environmentObject(eInterface)
            PersonalListView(ingredientList: Ingredient.data)
                .tabItem {
                    Label("Personal", systemImage: "scroll.fill")
                }
            HomeView(recipes: Recipe.getRecipes())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            MealViewer(recipeList: Recipe.getRecipes())
                .tabItem {
                    Label("MealViewer", systemImage: "calendar")
                }
            GroupsHomeView(groceries: Ingredient.data, users: UserModel.data)
                .tabItem {
                    Label("Group", systemImage: "person.3.fill")
                }
        }
        .onDisappear {
            let so = fbInterface.signOut()
            print(so)
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
