//
//  UserDB.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import FirebaseFirestoreSwift

struct UserDB : Codable {
    @DocumentID var id : String?
    var email : String
    var name : String
    var pantryList : [IngredientApi]
    var savedRecipes : [RecipeApi]
    var weeklyUserData: [WeeklyUserDataDB]
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case pantryList
        case savedRecipes
        case weeklyUserData
    }
}
