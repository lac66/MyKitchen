//
//  WeeklyUserData.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import Firebase

struct WeeklyUserDataDB : Codable {//, Hashable {
//    static func == (lhs: WeeklyUserDataDB, rhs: WeeklyUserDataDB) -> Bool {
//        return (lhs.startDate == rhs.startDate) && (lhs.personalList == rhs.personalList) && (lhs.recipesOfWeek == rhs.recipesOfWeek)
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(startDate)
//        hasher.combine(personalList)
//        hasher.combine(recipesOfWeek)
//    }
    
    let startDate: Date // need to format to timestamp, might cause an issue in a little bit... 11/10/21
    let personalList: [IngredientApi] // [Ingredient]
    let recipesOfWeek: [String:[RecipeApi]] // [DaysOfWeek:[Recipe]]
    
    enum CodingKeys: String, CodingKey {
        case startDate
        case personalList
        case recipesOfWeek
    }
}
