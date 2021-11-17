//
//  PersonalListView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import SwiftUI

struct PersonalListView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
    @State var addButtonImg = "plus"
    @State var searchText = ""
    @State var typingCheck: DispatchWorkItem?
    
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
                            Searchbar(placeholder: "Search here", isForRecipes: false, text: $searchText)
                                .onChange(of: searchText) { newValue in
                                    if (addButtonImg == "xmark") {
                                        if (typingCheck != nil) {
                                            typingCheck!.cancel()
                                            typingCheck = nil
                                        }
                                        
                                        typingCheck = DispatchWorkItem {
                                            print("search")
                                            searchApi()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: typingCheck!)
                                    }
                                }
                                .frame(width: 310)
                                .foregroundColor(Color("MintCream"))
                            
                            Spacer()
                            
                            Button {
                                if (addButtonImg == "plus") {
                                    addButtonImg = "xmark"
                                    searchText = ""
                                } else {
                                    addButtonImg = "plus"
                                    searchText = ""
                                }
                            } label: {
                                Image(systemName: addButtonImg)
                                    .frame(width: 30, height: 30)
                                    .background(Color("Camel"))
                                    .cornerRadius(10)
                            }
                        }
                        .frame(width: 350)
                    }
                    .foregroundColor(Color("MintCream"))
                    
                    ZStack {
                        ScrollView {
                            VStack (spacing: 10) {
                                // add logic for api vs list search here if/else
                                if fbInterface.currentUser!.weeklyUserData[fbInterface.currentUser!.weeklyUserData.count - 1].personalList.count == 0 {
                                    Text("No ingredients in Personal List")
                                        .foregroundColor(Color("MintCream"))
                                } else if !searchText.isEmpty && addButtonImg == "plus" {
                                    GroupingListView(ingredientList: fbInterface.searchPersonalList(text: searchText))
                                } else {
                                    GroupingListView(ingredientList: fbInterface.currentUser!.weeklyUserData[fbInterface.currentUser!.weeklyUserData.count - 1].personalList)
                                }
                            }
                        }
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .padding(.top)
                        .padding(.bottom, 10)
                        
                        if addButtonImg == "xmark" {
                            VStack {
                                ScrollView {
                                    VStack {
                                        ForEach(eInterface.ingredients, id: \.id) { ingredient in
                                            IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl, width: 340)
                                                .padding(5)
                                        }
                                    }
                                }
                            }
//                            .fixedSize(horizontal: true, vertical: false)
                            .frame(idealWidth: 350, idealHeight: 400)
                            .background(Color("Camel"))
                            .cornerRadius(15)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    func searchApi() {
        eInterface.searchWithApi(text: searchText, isForRecipes: false)
    }
}

struct GroupingListView: View {
    let ingredientList: [Ingredient]
    
    var body: some View {
        ForEach(0 ..< IngType.allCases.count) { index in
            VStack {
                Text(IngType.allCases[index].str)
                    .foregroundColor(Color("MintCream"))
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .padding(5)
                
                ForEach(ingredientList, id: \.id) { ingredient in
                    if (ingredient.type == IngType.allCases[index]) {
                        IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl, width: 340)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("OxfordBlue"), lineWidth: 2)
                            )
                            .padding(.bottom, 5)
                    }
                }
            }
            .frame(width: 350)
            .background(Color("AirBlue"))
            .cornerRadius(15)
        }
    }
}

struct PersonalListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalListView()
    }
}

