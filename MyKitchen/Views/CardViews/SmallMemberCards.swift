//
//  SmallMemberCards.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct SmallMemberCards: View {
    let user: User
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color("Marigold"))
                        .cornerRadius(10)
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("OxfordBlue"))
                }
                    
            }
            let fname = user.name.split(separator: " ")[0]
            Text(fname)
                .frame(width: 70, height: 20)
        }
    }
}
            

struct SmallMemberCards_Previews: PreviewProvider {
    static var user = User(id: "", email: "", name: "", pantryList: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], savedRecipes: [Recipe(id: "", name: "", imgUrl: "", sourceUrl: "", yield: 0.0, ingString: [""], ingredients: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], calories: 0.0, cuisineType: [""], mealType: [""], recipeInstructions: "")], weeklyUserData: [WeeklyUserData(startDate: Date(), personalList: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], recipesOfWeek: [DaysOfWeek.Sunday:[Recipe(id: "", name: "", imgUrl: "", sourceUrl: "", yield: 0.0, ingString: [""], ingredients: [Ingredient(id: "", text: "", quantity: 0.0, measure: "", food: "", weight: 0.0, foodCategory: "", imgUrl: "")], calories: 0.0, cuisineType: [""], mealType: [""], recipeInstructions: "")]])], groupID: "")
    static var previews: some View {
        SmallMemberCards(user: user)
    }
}
