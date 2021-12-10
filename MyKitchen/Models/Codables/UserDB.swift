//
//  UserDB.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import FirebaseFirestoreSwift

// model to send and receive user data from firebase
struct UserDB : Codable {
    @DocumentID var id : String?
    var email : String
    var name : String
    var pantryList : [IngredientApi]
    var savedRecipes : [RecipeApi]
    var weeklyUserData: [WeeklyUserDataDB]
    var groupID : String
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case pantryList
        case savedRecipes
        case weeklyUserData
        case groupID
    }
}
