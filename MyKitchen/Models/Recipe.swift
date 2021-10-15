//
//  Recipe.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import Foundation
import SwiftUI

struct Recipe {
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
            Recipe(name: "Chili", cookTime: "1 hour", difficulty: "Easy"),
            Recipe(name: "Chicken Parmesan", cookTime: "45 mins", difficulty: "Medium"),
            Recipe(name: "Brownies", cookTime: "50 mins", difficulty: "Easy"),
            Recipe(name: "Hamburger", cookTime: "30 mins", difficulty: "Easy"),
            Recipe(name: "Pizza", cookTime: "2 hours", difficulty: "Medium"),
            Recipe(name: "Sushi", cookTime: "20 mins", difficulty: "Hard"),
            Recipe(name: "Shrimp Boil", cookTime: "50 mins", difficulty: "Easy")
        ]
    }
}
