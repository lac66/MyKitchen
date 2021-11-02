//
//  UserModel.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import Foundation

struct UserModel : Identifiable, Hashable {
    public var id: Int
    public var name: String
    public var email: String
    public var password: String
    //public var mealForWeek: [DaysOfWeek: [Recipe]]  = [:]       //fix errors for this
}

extension UserModel {
    static var data : [UserModel]{
        [
            UserModel(id: 1, name: "Noah Gillespie", email:"ngilles5@uncc.edu", password: "test"),
            UserModel(id: 2, name: "Levi Carpenter", email:"idk@uncc.edu", password: "test"),
            UserModel(id: 3, name: "Erick Garcia", email: "EG@uncc.edu", password: "test")
        ]
    }
    
    static func getUser() -> [UserModel] {
        return UserModel.data
    }
}
