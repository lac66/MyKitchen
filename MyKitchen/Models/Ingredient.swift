//
//  Ingredient.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import Foundation
import SwiftUI

struct Ingredient: Identifiable {
    var id = UUID()
    let name: String
    var type: String?
    var qty: String?
    var img: UIImage?
    var items: [Ingredient]?
}


extension Ingredient {
    static var data: [Ingredient] {
        [
            Ingredient(name: "Milk", type: "Dairy", qty: "1 gallon"),
            Ingredient(name: "Cheese", type: "Dairy", qty: "16 oz"),
            Ingredient(name: "Lettuce", type: "Vegetable", qty: "1 unit"),
            Ingredient(name: "Pasta", type: "Grain", qty: "8 oz"),
            Ingredient(name: "Apple", type: "Fruit", qty: "2 units"),
            Ingredient(name: "Ground Beef", type: "Protein", qty: "2 lbs")
        ]
        
        
    }
    
    
}



