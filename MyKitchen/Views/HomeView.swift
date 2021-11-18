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
    @State var task: DispatchWorkItem?
    
    var body: some View {
        VStack {
            Button {
                print("pressed")
                if (task != nil) {
                    task!.cancel()
                    task = nil
                }
                
                task = DispatchWorkItem {
                    print("search")
                    eInterface.searchWithApi(text: "Chicken", isForRecipes: true)
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task!)
            } label: {
                Text("Press Me")
            }
        }
//        NavigationView {
//            ZStack {
//                VStack {
//                    HStack {
//                        NavigationLink(destination: PlanningView(recipeList: Recipe.getRecipes())){
//                            Text("Planning")
//                                .frame(width: 360, height: 100)
//                                .background(Color.green)
//                                .font(.system(size: 20, weight: .bold, design: .default))
//                                .cornerRadius(10)
//                                .padding()
//
//                            }
//
//                    }
//                    HStack {
////                        Temp link to HomeView while we don't have 'peronal list' set up yet
//                        NavigationLink(destination: HomeView(recipes: recp)) {
//                            Text("Personal List")
//                                .frame(width: 100, height: 150)
//                                .background(Color.green)
//                                .font(.system(size: 20, weight: .bold, design: .default))
//                                .cornerRadius(10)
//                        }
////                        Temp link to Home view while we don't have 'i'm shopping' set up yet
//                        NavigationLink(destination: HomeView(recipes: recp)){
//                            Text("I'm Shopping")
//                                .frame(width: 150, height: 150)
//                                .background(Color.green)
//                                .font(.system(size: 20, weight: .bold, design: .default))
//                                .cornerRadius(75)
//    //                            .padding(.horizontal, 5)
//                        }
////                        Temp link to HomeView while we don't have 'groups' set up yet
//                        NavigationLink(destination: HomeView(recipes: recp)) {
//                            Text("Group List")
//                                .frame(width: 100, height: 150)
//                                .background(Color.green)
//                                .font(.system(size: 20, weight: .bold, design: .default))
//                                .cornerRadius(10)
//                        }
//                    }
////                    Both temp links pages not set up yet
//                    HStack {
//                        NavigationLink(destination: HomeView(recipes: recp)) {
//                            Text("Meal Viewer")
//                                .frame(width: 160, height: 100)
//                                .background(Color.green)
//                                .font(.system(size: 20, weight: .bold, design: .default))
//                                .cornerRadius(10)
//                                .padding()
//                        }
//                    NavigationLink(destination: HomeView(recipes: recp)) {
//                            Text("Pantry")
//                                .frame(width: 160, height: 100)
//                                .background(Color.green)
//                                .font(.system(size: 20, weight: .bold, design: .default))
//                                .cornerRadius(10)
//                                .padding()
//                        }
//                    }
//                }
//            }
//        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
