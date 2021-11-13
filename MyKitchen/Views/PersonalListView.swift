//
//  PersonalListView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import SwiftUI

struct PersonalListView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @State var addButtonImg = "plus"
    @State var searchText = ""
    
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
                    VStack (alignment: .leading) {
                        Text("Personal List")
                            .font(.system(size: 32, weight: .bold, design: .default))
                        
                        HStack {
                            Searchbar(placeholder: Text("Search here"), isForRecipes: false, text: $searchText)
                                .frame(width: 300)
                                .foregroundColor(Color("MintCream"))
                            
                            Button {
                                if (addButtonImg == "plus") {
                                    addButtonImg = "xmark"
                                } else {
                                    addButtonImg = "plus"
                                }
                            } label: {
                                Image(systemName: addButtonImg)
                                    .frame(width: 30, height: 30)
                                    .background(Color("Camel"))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    .foregroundColor(Color("MintCream"))
                    .padding(.bottom)
                    
                    ScrollView {
                        VStack (spacing: 10) {
                            // add logic for api vs list search here if/else
                            ForEach(0 ..< IngType.allCases.count) { index in
                                VStack {
                                    Text(IngType.allCases[index].str)
                                        .foregroundColor(Color("MintCream"))
                                        .font(.system(size: 24, weight: .semibold, design: .default))
                                        .padding(5)
                                    
                                    ForEach(fbInterface.currentUser!.weeklyUserData[fbInterface.currentUser!.weeklyUserData.count - 1].personalList, id: \.id) { ingredient in
                                        if (ingredient.type == IngType.allCases[index]) {
                                            IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl)
                                        }
                                    }
                                }
                                .background(Color("AirBlue"))
                                .cornerRadius(15)
                            }
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .padding(.bottom, 10)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct PersonalListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalListView()
    }
}

