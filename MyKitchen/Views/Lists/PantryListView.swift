//
//  PantryListView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/18/21.
//

import SwiftUI
import ToastViewSwift

// pantry page, similar to personal list
struct PantryListView: View {
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
                        Text("Pantry List")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        
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
                                    let toast = Toast.text("Search Ingredients to Add")
                                    toast.show()
                                } else {
                                    addButtonImg = "plus"
                                    searchText = ""
                                }
                            } label: {
                                Image(systemName: addButtonImg)
                                    .frame(width: 30, height: 30)
                                    .background(Color("Camel"))
                                    .cornerRadius(12)
                            }
                        }
                        .frame(width: 350)
                    }
                    .foregroundColor(Color("MintCream"))
                    
                    ZStack {
                        ScrollView {
                            VStack (spacing: 10) {
                                if fbInterface.currentUser!.pantryList.count == 0 {
                                    Text("No ingredients in Pantry List")
                                        .foregroundColor(Color("MintCream"))
                                } else if !searchText.isEmpty && addButtonImg == "plus" {
                                    PantryGroupingListView(ingredientList: fbInterface.searchPantryList(text: searchText))
                                } else {
                                    PantryGroupingListView(ingredientList: fbInterface.currentUser!.pantryList)
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
                                            IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl, trashOrAdd: "plus", isPersonalList: false)
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                            .onDisappear() {
                                eInterface.ingredients.removeAll()
                            }
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
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

struct PantryGroupingListView: View {
    @State var collapsed: [Bool]
    @State var arrowTabArr: [String]
    let ingredientList: [Ingredient]
    
    init (ingredientList: [Ingredient]) {
        self.ingredientList = ingredientList.sorted(by: { $0.food.lowercased() < $1.food.lowercased() })
        
        var tmpArr: [Bool] = []
        var tmpArr2: [String] = []
        for _ in IngType.allCases {
            tmpArr.append(true)
            tmpArr2.append("arrowtriangle.down.fill")
        }
        self.collapsed = tmpArr
        self.arrowTabArr = tmpArr2
    }
    
    var body: some View {
        ForEach(0 ..< IngType.allCases.count) { index in
            VStack {
                ZStack {
                    HStack {
                        Image(systemName: arrowTabArr[index])
                            .padding(.leading)
                        Spacer()
                    }
                    
                    Text(IngType.allCases[index].str)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .padding(5)
                }
                .foregroundColor(Color("MintCream"))
                
                if (collapsed[index]) {
                    ForEach(ingredientList, id: \.id) { ingredient in
                        if (ingredient.type == IngType.allCases[index]) {
                            IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl, trashOrAdd: "trash", isPersonalList: false)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("OxfordBlue"), lineWidth: 2)
                                )
                                .padding(.bottom, 5)
                        }
                    }
                }
            }
            .frame(width: 350)
            .background(Color("AirBlue"))
            .cornerRadius(15)
            .onTapGesture(count: 2) {
                if (collapsed[index]) {
                    collapsed[index] = false
                    arrowTabArr[index] = "arrowtriangle.right.fill"
                } else {
                    collapsed[index] = true
                    arrowTabArr[index] = "arrowtriangle.down.fill"
                }
            }
        }
    }
}

struct PantryListView_Previews: PreviewProvider {
    static var previews: some View {
        PantryListView()
    }
}

