//
//  GroupsHomeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI
import ToastViewSwift

struct GroupsHomeView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @EnvironmentObject var eInterface : EdamamInterface
    
    @State var addButtonImg = "plus"
    @State var searchText = ""
    @State var typingCheck: DispatchWorkItem?
    
    //    let group: GroupDB
    //    init(group: GroupDB){
    //        self.group = group
    //    }
    
    var body: some View {
        //        List(groupByCategory, children: \.item) { row in
        //            Text("Hello")
        //         }
        NavigationView{
            ZStack{
                //            Text(fbInterface.currentUser?.groupID ?? "None found")
                Color("OxfordBlue")
                    .ignoresSafeArea()
                
                VStack (alignment: .leading) {
                    Text("Group")
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    
                    VStack (alignment: .center) {
                        Text("Current user group ID: ")
                        Text(self.fbInterface.currentUser!.groupID)
                            .frame(width: 350)
                    }
                    .background(Color("AirBlue"))
                    .foregroundColor(Color("MintCream"))
                    .cornerRadius(10)
                    
                    VStack{
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
                        ZStack{
                            HStack{
                                ForEach(fbInterface.currentGroup!.members, id: \.id) { member in
                                    SmallMemberCards(user: member)
                                }
                            }
                            .frame(width: 330, height: 100)
                            .background(Color("MintCream"))
                            .cornerRadius(15)
                        }
                        .frame(width: 350, height: 120)
                        .background(Color("AirBlue"))
                        .cornerRadius(15)
                        
                        HStack{
                            NavigationLink(destination: GroupsInitialView().onAppear{
                                self.fbInterface.leaveGroup()
                            }.navigationBarBackButtonHidden(true)){
                                Text("leave group")
                            }
                            .foregroundColor(Color("MintCream"))
                            NavigationLink(destination: GroupsCardHolderView()){
                                Text("Edit group")
                            }
                        }
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
    func searchApi() {
        eInterface.searchWithApi(text: searchText, isForRecipes: false)
    }
}

struct GroupingListViewGroups: View {
    @State var collapsed: [Bool]
    @State var arrowTabArr: [String]
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


//struct GroupsHomeView_Previews: PreviewProvider {
//    let groceries: [Ingredient]
//    let usersTest: [UserModel]
//    static var previews: some View {
//        GroupsHomeView(groupList:usersTest)
//    }
//}
