//
//  ContentView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color("AirBlue"))
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("MintCream"))
    }
    
    var body: some View {
        TabView {
            // Text("PlanningView()") can be replaced with view to be showed on click
//            Text("PlanningView()")
            PlanningView(recipeList: Recipe.getRecipes())
                .tabItem {
                    Label("Planning", systemImage: "magnifyingglass")
                }
            Text("PersonalList()")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
