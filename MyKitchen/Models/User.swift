//
//  User.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation

class User : ObservableObject {
    let id : String
    let email : String
    let name : String
    var pantryList : [Ingredient]
    var weeklyUserData: [WeeklyUserData]

    init(id: String, email: String, name: String, pantryList: [Ingredient], weeklyUserData: [WeeklyUserData]) {
        self.id = id
        self.email = email
        self.name = name
        self.pantryList = pantryList
        self.weeklyUserData = weeklyUserData
    }
    
    func toString() -> String {
        return "id: \(String(describing: id)), email: \(email), name: \(name), pantryList: \(pantryList), weeklyUserData: \(weeklyUserData)"
    }
}

//class User : ObservableObject {
//    var id : String?
//    let email : String
//    let name : String
//    let pantryList : [Ingredient]
////    let weeklyUserData: [WeeklyUserData]
//
//    init(id: String, email: String, name: String, pantryList: [Ingredient]) {
//        self.id = id
//        self.email = email
//        self.name = name
//        self.pantryList = pantryList
////        self.weeklyUserData = weeklyUserData
//    }
//
//    func toString() -> String {
//        return "id: \(String(describing: id)), email: \(email), name: \(name), pantryList: \(pantryList)"
//    }
//}
