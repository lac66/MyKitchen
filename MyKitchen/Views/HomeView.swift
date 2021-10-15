//
//  HomeView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        print("tapped Planning")
                    } label: {
                        Text("Planning")
                            .frame(width: 360, height: 100)
                            .background(Color.green)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                            .padding()
                    }
                }
                HStack {
                    Button {
                        print("tapped Personal List")
                    } label: {
                        Text("Personal List")
                            .frame(width: 100, height: 150)
                            .background(Color.green)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                    }
                    Button {
                        print("tapped I'm Shopping")
                    } label: {
                        Text("I'm Shopping")
                            .frame(width: 150, height: 150)
                            .background(Color.green)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(75)
//                            .padding(.horizontal, 5)
                    }
                    Button {
                        print("tapped Group List")
                    } label: {
                        Text("Group List")
                            .frame(width: 100, height: 150)
                            .background(Color.green)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                    }
                }
                HStack {
                    Button {
                        print("tapped Meal Viewer")
                    } label: {
                        Text("Meal Viewer")
                            .frame(width: 160, height: 100)
                            .background(Color.green)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                            .padding()
                    }
                    Button {
                        print("tapped Pantry")
                    } label: {
                        Text("Pantry")
                            .frame(width: 160, height: 100)
                            .background(Color.green)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
