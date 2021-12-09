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
    @State private var tabSelection = 2
    
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
        TabView (selection: $tabSelection) {
            PlanningView()
                .tabItem {
                    Label("Planning", systemImage: "magnifyingglass")
                }
                .tag(0)
                .environmentObject(fbInterface)
                .environmentObject(eInterface)
            PersonalListView()
                .tabItem {
                    Label("Personal", systemImage: "scroll.fill")
                }
                .tag(1)
                .environmentObject(fbInterface)
                .environmentObject(eInterface)
            HomeView(tabSelection: $tabSelection, name: fbInterface.currentUser?.name)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(2)
                .environmentObject(fbInterface)
            MealViewer()
                .tabItem {
                    Label("MealViewer", systemImage: "calendar")
                }
                .tag(3)
                .environmentObject(fbInterface)
            CheckHasGroup()
                .tabItem {
                    Label("Group", systemImage: "person.3.fill")
                }
                .tag(4)
                .environmentObject(fbInterface)
//            ShoppingView()
//                .tag(5)
//                .environmentObject(fbInterface)
//            PantryListView()
//                .tag(6)
//                .environmentObject(fbInterface)
        }
        .onAppear() {
//            let value = tabSelection
//            tabSelection = -1
//            DispatchQueue.main.async {
//                tabSelection = value
//            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
