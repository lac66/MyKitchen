//
//  User.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation

struct User {
    let id : String
    let email : String
    let name : String
    var pantryList : [Ingredient]
    var savedRecipes : [Recipe]
    var weeklyUserData: [WeeklyUserData]
    var groupID : String?
    
    init(id: String, email: String, name: String, pantryList: [Ingredient], savedRecipes: [Recipe], weeklyUserData: [WeeklyUserData]) {
        self.id = id
        self.email = email
        self.name = name
        self.pantryList = pantryList
        self.savedRecipes = savedRecipes
        self.weeklyUserData = weeklyUserData
        self.groupID = nil
    }

//    init(id: String, email: String, name: String, pantryList: [Ingredient], savedRecipes: [Recipe], weeklyUserData: [WeeklyUserData], groupID: String?) {
//        self.id = id
//        self.email = email
//        self.name = name
//        self.pantryList = pantryList
//        self.savedRecipes = savedRecipes
//        self.weeklyUserData = weeklyUserData
//        self.groupID = groupID
//    }
//
//    init(id: String, email: String, name: String, pantryList: [Ingredient], savedRecipes: [Recipe], weeklyUserData: [WeeklyUserData]) {
//        self.id = id
//        self.email = email
//        self.name = name
//        self.pantryList = pantryList
//        self.savedRecipes = savedRecipes
//        self.weeklyUserData = weeklyUserData
//        self.groupID = nil
//    }
    
    
    func toString() -> String {
        return "id: \(String(describing: id)), email: \(email), name: \(name), pantryList: \(pantryList), savedRecipes: \(savedRecipes) weeklyUserData: \(weeklyUserData)"
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
