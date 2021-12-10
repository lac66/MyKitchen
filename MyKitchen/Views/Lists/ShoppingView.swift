//
//  ShoppingView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 12/1/21.
//

import SwiftUI

// shopping page
struct ShoppingView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
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
                    // title and searchbar stack
                    VStack (alignment: .leading) {
                        Text("Grocery List")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        
                        Searchbar(placeholder: "Search here", isForRecipes: false, text: $searchText)
                            .frame(width: 350)
                            .foregroundColor(Color("MintCream"))
                    }
                    .foregroundColor(Color("MintCream"))
                    
                    ScrollView {
                        VStack (alignment: .leading, spacing: 10) {
                            // personal list section
                            Text("Personal")
                                .foregroundColor(Color("MintCream"))
                                .font(.system(size: 26, weight: .bold, design: .default))
                            
                            if fbInterface.currentUser!.weeklyUserData[fbInterface.currentUser!.weeklyUserData.count - 1].personalList.count == 0 {
                                Text("No ingredients in Personal Shopping List")
                                    .foregroundColor(Color("MintCream"))
                            } else if !searchText.isEmpty {
                                ShoppingListGroupingView(ingredientList: fbInterface.searchPersonalList(text: searchText))
                            } else {
                                ShoppingListGroupingView(ingredientList: fbInterface.currentUser!.weeklyUserData[fbInterface.currentUser!.weeklyUserData.count - 1].personalList)
                            }
                            
                            // group list section
                            Text("Group")
                                .foregroundColor(Color("MintCream"))
                                .font(.system(size: 26, weight: .bold, design: .default))
                            
                            if fbInterface.currentGroup!.groupList.count == 0 {
                                Text("No ingredients in Group Shopping List")
                                    .foregroundColor(Color("MintCream"))
                            } else if !searchText.isEmpty {
                                GroupShoppingListGroupingView(ingredientList: fbInterface.searchGroupList(text: searchText))
                            } else {
                                GroupShoppingListGroupingView(ingredientList: fbInterface.currentGroup!.groupList)
                            }
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .padding(.top)
                    .padding(.bottom, 10)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

// subview to handle grouping, collapsable, and check off
struct ShoppingListGroupingView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    @State var collapsed: [Bool]
    @State var arrowTabArr: [String]
    
    @State var checkedOffBools: [Bool]
    @State var checkedOffIngredients: [Ingredient] = []
    
    let ingredientList: [Ingredient]
    
    init (ingredientList: [Ingredient]) {
        self.ingredientList = ingredientList
        
        var tmpArr: [Bool] = []
        var tmpArr2: [String] = []
        for _ in IngType.allCases {
            tmpArr.append(true)
            tmpArr2.append("arrowtriangle.down.fill")
        }
        self.collapsed = tmpArr
        self.arrowTabArr = tmpArr2
        
        tmpArr.removeAll()
        for _ in ingredientList {
            tmpArr.append(false)
        }
        self.checkedOffBools = tmpArr
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
                            if (checkedOffIngredients.contains(ingredient)) {
                                ShoppingCardView(ingredient: ingredient, withURL: ingredient.imgUrl, checkedOff: true)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("OxfordBlue"), lineWidth: 2)
                                    )
                                    .padding(.bottom, 5)
                                    .onTapGesture {
                                        removeIngredient(ingredient: ingredient)
                                    }
                            } else {
                                ShoppingCardView(ingredient: ingredient, withURL: ingredient.imgUrl, checkedOff: false)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("OxfordBlue"), lineWidth: 2)
                                    )
                                    .padding(.bottom, 5)
                                    .onTapGesture {
                                        checkedOffIngredients.append(ingredient)
                                    }
                            }
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
        .onDisappear() {
            fbInterface.finishedShopping(checkedOffList: checkedOffIngredients)
        }
    }
    
    // function to remove ingredient from checked off list
    func removeIngredient(ingredient: Ingredient) {
        checkedOffIngredients.remove(at: checkedOffIngredients.firstIndex(of: ingredient)!)
    }
}

// subview similar to above, except for group list
struct GroupShoppingListGroupingView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    @State var collapsed: [Bool]
    @State var arrowTabArr: [String]
    
    @State var checkedOffBools: [Bool]
    @State var checkedOffIngredients: [Ingredient] = []
    
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
        
        tmpArr.removeAll()
        for _ in ingredientList {
            tmpArr.append(false)
        }
        self.checkedOffBools = tmpArr
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
                            if (checkedOffIngredients.contains(ingredient)) {
                                ShoppingCardView(ingredient: ingredient, withURL: ingredient.imgUrl, checkedOff: true)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("OxfordBlue"), lineWidth: 2)
                                    )
                                    .padding(.bottom, 5)
                                    .onTapGesture {
                                        removeIngredient(ingredient: ingredient)
                                    }
                            } else {
                                ShoppingCardView(ingredient: ingredient, withURL: ingredient.imgUrl, checkedOff: false)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("OxfordBlue"), lineWidth: 2)
                                    )
                                    .padding(.bottom, 5)
                                    .onTapGesture {
                                        checkedOffIngredients.append(ingredient)
                                    }
                            }
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
        .onDisappear() {
            fbInterface.finishedShoppingGroup(checkedOffList: checkedOffIngredients)
        }
    }
    
    func removeIngredient(ingredient: Ingredient) {
        checkedOffIngredients.remove(at: checkedOffIngredients.firstIndex(of: ingredient)!)
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
