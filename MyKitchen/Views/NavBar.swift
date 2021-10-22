//
//  NavBar.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct NavBar: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color("AirBlue"))
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("MintCream"))
    }
    
    var body: some View {
        TabView {
            // Text("PlanningView()") can be replaced with view to be showed on click
            Text("PlanningView()")
                .tabItem {
                    Label("Planning", systemImage: "magnifyingglass")
                }
            Text("PersonalListView()")
                .tabItem {
                    Label("Personal", systemImage: "scroll.fill")
                }
            Text("HomeView()")
                .tabItem {
                    Circle()
                        .foregroundColor(Color("Camel"))
                        
                    Label("Home", systemImage: "house.fill")
                }
            Text("MealViewerView()")
                .tabItem {
                    Label("MealViewer", systemImage: "calendar")
                }
            Text("GroupView()")
                .tabItem {
                    Label("Group", systemImage: "person.3.fill")
                }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
