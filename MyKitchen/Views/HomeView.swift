//
//  HomeView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
    @Binding var tabSelection: Int
    let name: String?
    
    init(tabSelection: Binding<Int>, name: String?) {
        self._tabSelection = tabSelection
        self.name = name
        
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "MintCream")!]
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 24)!]
//
//        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)

                VStack (spacing: 10) {
                    HStack (spacing: 10) {
//                        NavigationLink(destination: PlanningView()){
                            Text("Planning")
                                .frame(width: 170, height: 230)
                                .background(Color("AirBlue"))
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .cornerRadius(10)
                                .onTapGesture {
                                    tabSelection = 0
                                }

//                        }

//                        NavigationLink(destination: PersonalListView()) {
                            Text("Personal List")
                                .frame(width: 170, height: 230)
                                .background(Color("AirBlue"))
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .cornerRadius(10)
                                .onTapGesture {
                                    tabSelection = 1
                                }
//                        }
                    }

                    HStack (spacing: 10) {
//                        NavigationLink(destination: MealViewer()) {
                            Text("Meal Viewer")
                                .frame(width: 170, height: 230)
                                .background(Color("AirBlue"))
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .cornerRadius(10)
                                .onTapGesture {
                                    tabSelection = 3
                                }
//                        }

//                        NavigationLink(destination: GroupsHomeView()) {
                            Text("Group List")
                                .frame(width: 170, height: 230)
                                .background(Color("AirBlue"))
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .cornerRadius(10)
                                .onTapGesture {
                                    tabSelection = 4
                                }
//                        }
                    }

                    NavigationLink(destination: ShoppingView()){
                        Text("I'm Shopping")
                            .frame(width: 350, height: 60)
                            .background(Color("AirBlue"))
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: PantryListView()) {
                        Text("Pantry")
                            .frame(width: 350, height: 50)
                            .background(Color("AirBlue"))
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                    }
                }
                .frame(width: 350, height: 600)
                .foregroundColor(Color("MintCream"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if (name != nil) {
                            Text("Welcome, \(name!)")
                                .foregroundColor(Color("MintCream"))
                                .font(.system(size: 36, weight: .bold, design: .default))
                        } else {
                            Text("Welcome")
                                .foregroundColor(Color("MintCream"))
                                .font(.system(size: 36, weight: .bold, design: .default))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            fbInterface.signOut()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                    }
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var tab = 2
    @State static var n = "Name"
    
    static var previews: some View {
        HomeView(tabSelection: $tab, name: n)
    }
}
