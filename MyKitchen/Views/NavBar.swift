//
//  NavBar.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct NavBar: View {
//    @EnvironmentObject var currUser : User
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
            PlanningView()
                .tabItem {
                    Label("Planning", systemImage: "magnifyingglass")
                }
                .environmentObject(fbInterface)
                .environmentObject(eInterface)
            // will get data from user observable obj
            PersonalListView()
                .tabItem {
                    Label("Personal", systemImage: "scroll.fill")
                }
                .environmentObject(fbInterface)
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .environmentObject(fbInterface)
            // will get data from user observable obj
            MealViewer()
                .tabItem {
                    Label("MealViewer", systemImage: "calendar")
                }
                .environmentObject(fbInterface)
            // will get data from user observable obj
            GroupsHomeView()
                .tabItem {
                    Label("Group", systemImage: "person.3.fill")
                }
                .environmentObject(fbInterface)
        }
//        .onDisappear {
//            let so = fbInterface.signOut()
//            print(so)
//        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
