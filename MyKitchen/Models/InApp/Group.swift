//
//  Group.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/12/21.
//

import Foundation

// model to hold group data
struct Group {
    let groupID : String
    var groupList : [Ingredient]
    let leaderID : String
    var members : [UserGroup]
    
    func toString() -> String {
        return "groupID: \(String(describing: groupID)), groupList: \(groupList), leaderID: \(leaderID), members: \(members)"
    }
}
