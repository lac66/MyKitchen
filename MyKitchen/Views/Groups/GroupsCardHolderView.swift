//
//  GroupsView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsCardHolderView: View {
    let users: [User]
    init(groupList: [User]) {
        users = groupList
        
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    var body: some View {
       // MemberCards(users: users)
        VStack(spacing: 10) {
//            ForEach(users, id: \.self) { user in
//                MemberCards(users: user)
//            }
            HStack{
                Button("Add / Remove"){
                    
                }
                    .frame(width: 160, height: 40)
                    .background(Color("AirBlue"))
                    .foregroundColor(Color("MintCream"))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding()
                Button("Leave group") {
                }
                    .frame(width: 160, height: 40)
                    .background(Color("AirBlue"))
                    .foregroundColor(Color("MintCream"))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding()
            }
        }
        .padding(.top)
    }
}


struct GroupsView_Previews: PreviewProvider {
    static var users = [User(id: "", email: "", name: "", pantryList: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], savedRecipes: [Recipe(id: "", name: "", imgUrl: "", sourceUrl: "", yield: 0.0, ingString: [""], ingredients: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], calories: 0.0, cuisineType: [""], mealType: [""], recipeInstructions: "")], weeklyUserData: [WeeklyUserData(startDate: Date(), personalList: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], recipesOfWeek: [DaysOfWeek.Sunday:[Recipe(id: "", name: "", imgUrl: "", sourceUrl: "", yield: 0.0, ingString: [""], ingredients: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], calories: 0.0, cuisineType: [""], mealType: [""], recipeInstructions: "")]])], groupID: "")]
    static var previews: some View {
        GroupsCardHolderView(groupList: users)
    }
}
