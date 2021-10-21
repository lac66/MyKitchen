//
//  Recipe.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable {
    var id: Int
    let name: String
    let cookTime: String
    let difficulty: String
    var ingredients: Array<String>?
    var instructions: String?
    var img: UIImage?
    
}

extension Recipe {
    static var data: [Recipe] {
        [
            Recipe(id: 1, name: "Chili", cookTime: "1 hour", difficulty: "Easy"),
            Recipe(id: 2, name: "Chicken Parmesan", cookTime: "45 mins", difficulty: "Medium"),
            Recipe(id: 3, name: "Brownies", cookTime: "50 mins", difficulty: "Easy"),
            Recipe(id: 4, name: "Hamburger", cookTime: "30 mins", difficulty: "Easy"),
            Recipe(id: 5, name: "Pizza", cookTime: "2 hours", difficulty: "Medium"),
            Recipe(id: 6, name: "Sushi", cookTime: "20 mins", difficulty: "Hard"),
            Recipe(id: 7, name: "Shrimp Boil", cookTime: "50 mins", difficulty: "Easy")
        ]
    }
}
