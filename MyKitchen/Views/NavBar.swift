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
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            
            tabBarAppearance.backgroundColor = UIColor(Color("AirBlue"))
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color("Marigold"))]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color("MintCream"))]
            
            
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        } else {
            UITabBar.appearance().barTintColor = UIColor(Color("AirBlue"))
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color("MintCream"))
        }
    }
    
    var body: some View {
        TabView (selection: $initialIndex) {
            PlanningView()
                .tabItem {
                    Label("Planning", systemImage: "magnifyingglass")
                }
                .environmentObject(fbInterface)
                .environmentObject(eInterface)
            PersonalListView()
                .tabItem {
                    Label("Personal", systemImage: "scroll.fill")
                }
                .environmentObject(fbInterface)
                .environmentObject(eInterface)
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .environmentObject(fbInterface)
            MealViewer()
                .tabItem {
                    Label("MealViewer", systemImage: "calendar")
                }
                .environmentObject(fbInterface)
            GroupsHomeView()
                .tabItem {
                    Label("Group", systemImage: "person.3.fill")
                }
                .environmentObject(fbInterface)
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
