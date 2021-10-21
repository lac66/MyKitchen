//
//  Ingredient.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import Foundation
import SwiftUI

struct Ingredient: Identifiable {
    var id: Int
    let name: String
    var type: String?
    var qty: String?
    var img: UIImage?
    
}

extension Ingredient {
    static var data: [Ingredient] {
        [
            Ingredient(id: 1, name: "Milk", type: "Dairy", qty: "1 gallon"),
            Ingredient(id: 2, name: "Cheese", type: "Dairy", qty: "16 oz"),
            Ingredient(id: 3, name: "Lettuce", type: "Vegetable", qty: "1 unit"),
            Ingredient(id: 4, name: "Pasta", type: "Grain", qty: "8 oz"),
            Ingredient(id: 5, name: "Apple", type: "Fruit", qty: "2 units"),
            Ingredient(id: 6, name: "Ground Beef", type: "Protein", qty: "2 lbs")
        ]
    }
}
