//
//  GroupsHomeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import Combine
import UIKit
import SwiftUI
import ToastViewSwift

// group home page
struct GroupsHomeView: View, KeyboardReadable {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
    @State var addButtonImg = "plus"
    @State var searchText = ""
    @State var typingCheck: DispatchWorkItem?
    
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("OxfordBlue")
                    .ignoresSafeArea()
                
                // stack for title, searchbar, and add button
                VStack (alignment: .leading) {
                    Text("Group Home")
                        .foregroundColor(Color("MintCream"))
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
                            .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                isKeyboardVisible = newIsKeyboardVisible
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
                    .foregroundColor(Color("MintCream"))
                    
                    // stack for displaying grouplist
                    ZStack {
                        ScrollView {
                            VStack (spacing: 10) {
                                if fbInterface.currentGroup!.groupList.count == 0 {
                                    Text("No ingredients in group list")
                                        .foregroundColor(Color("MintCream"))
                                } else if !searchText.isEmpty && addButtonImg == "plus" {
                                    GroupingListViewGroups(ingredientList: fbInterface.searchGroupList(text: searchText))
                                } else {
                                    GroupingListViewGroups(ingredientList: fbInterface.currentGroup!.groupList)
                                    // add .count if there is an issue later
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
                                            GroupIngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl, trashOrAdd: "plus")
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
                    .background(Color("OxfordBlue"))
                    
                    // stack for showing current members
                    if !isKeyboardVisible {
                        ZStack{
                            VStack{
                                HStack{
                                    Text("Current members")
                                        .frame(width: 295, height: 15, alignment: .leading)
                                        .foregroundColor(Color("OxfordBlue"))
                                        .font(.system(size: 18, weight: .semibold, design: .default))
                                    
                                    NavigationLink(destination: GroupsCardHolderView()){
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .frame(width: 15, height: 15, alignment: .trailing)
                                            .padding(2)
                                            .background(Color("Camel"))
                                            .foregroundColor(Color("MintCream"))
                                            .cornerRadius(4)
                                            .padding(.top, 5)
                                    }
                                    
                                }
                                HStack{
                                    ForEach(fbInterface.currentGroup!.members, id: \.id) { member in
                                        SmallMemberCards(user: member)
                                    }
                                }
                            }
                        }
                        .frame(width: 350, height: 120)
                        .background(Color("AirBlue"))
                        .cornerRadius(15)
                        .padding(.bottom)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // function to search api
    func searchApi() {
        eInterface.searchWithApi(text: searchText, isForRecipes: false)
    }
}

// subview for grouping and collapsing list
struct GroupingListViewGroups: View {
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
                            GroupIngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl, trashOrAdd: "trash")
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

// Publisher to read keyboard changes.
// informs app when keyboard is active
protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

// updates protocol
extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
            .eraseToAnyPublisher()
    }
}

struct GroupsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsHomeView()
    }
}
