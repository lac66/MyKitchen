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
    var qty: Quantity?
    var img: Image?
    var items: [Ingredient]?
}


extension Ingredient {
    static var data: [Ingredient] {
        [
            Ingredient(name: "Milk", type: "Dairy", qty: Quantity(amt: 1, unit: Unit.gal), img: Image("milk")),
            Ingredient(name: "Cheese", type: "Dairy", qty: Quantity(amt: 16, unit: Unit.oz), img: Image("milk")),
            Ingredient(name: "Lettuce", type: "Vegetable", qty: Quantity(amt: 1, unit: Unit.unit), img: Image("milk")),
            Ingredient(name: "Pasta", type: "Grain", qty: Quantity(amt: 8, unit: Unit.oz), img: Image("milk")),
            Ingredient(name: "Apple", type: "Fruit", qty: Quantity(amt: 2, unit: Unit.unit), img: Image("milk")),
            Ingredient(name: "Ground Beef", type: "Protein", qty: Quantity(amt: 2, unit: Unit.lb), img: Image("milk"))
        ]
        
        
    }
    static func getIngredient() -> [Ingredient] {
        return Ingredient.data
    }
    
    
}



