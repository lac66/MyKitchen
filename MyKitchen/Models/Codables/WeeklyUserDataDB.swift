//
//  WeeklyUserData.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import Firebase

// model encapsulated by userdb to send and receive weekly user data
struct WeeklyUserDataDB : Codable {
    let startDate: Date
    let personalList: [IngredientApi]
    let recipesOfWeek: [String:[RecipeApi]]
    
    enum CodingKeys: String, CodingKey {
        case startDate
        case personalList
        case recipesOfWeek
    }
}
