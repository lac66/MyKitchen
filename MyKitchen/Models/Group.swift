//
//  Group.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/12/21.
//

import Foundation

struct Groups {
    let groupID : String
    var groupList : [Ingredient]
    let leaderID : String
    var members : [User]
    
    init(groupID: String, groupList: [Ingredient], leaderID: String, members: [User]){
        self.groupID = groupID
        self.groupList = groupList
        self.leaderID = leaderID
        self.members = members
    }
    
    func toString() -> String {
        return "groupID: \(String(describing: groupID)), groupList: \(groupList), leaderID: \(leaderID), members: \(members)"
    }
}
