//
//  GroupDB.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/24/21.
//

import Foundation
import FirebaseFirestoreSwift

struct GroupDB : Codable {
    @DocumentID var groupID : String?
    var groupList : [IngredientApi]
    let leaderID : String
    var members : [UserGroup]
    
    enum CodingKeys: String, CodingKey {
        case groupID
        case groupList
        case leaderID
        case members
    }
}

