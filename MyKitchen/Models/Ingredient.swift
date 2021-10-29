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
    var img: Image?
    var items: [Ingredient]?
}


extension Ingredient {
    static var data: [Ingredient] {
        [
            Ingredient(name: "Milk", type: "Dairy", qty: "1 gallon", img: Image("milk")),
            Ingredient(name: "Cheese", type: "Dairy", qty: "16 oz", img: Image("milk")),
            Ingredient(name: "Lettuce", type: "Vegetable", qty: "1 unit", img: Image("milk")),
            Ingredient(name: "Pasta", type: "Grain", qty: "8 oz", img: Image("milk")),
            Ingredient(name: "Apple", type: "Fruit", qty: "2 units", img: Image("milk")),
            Ingredient(name: "Ground Beef", type: "Protein", qty: "2 lbs", img: Image("milk"))
        ]
        
        
    }
    
    
}



