//
//  UserGroup.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 12/7/21.
//

import Foundation

struct UserGroup : Codable {
    var id : String
    var email : String
    var name : String
    var groupID : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case groupID
    }
}
