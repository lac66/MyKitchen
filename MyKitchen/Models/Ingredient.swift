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
    var type: IngType?
    var qty: Quantity?
    var img: Image?
    var items: [Ingredient]?
}


extension Ingredient {
    static var data: [Ingredient] {
        [
            Ingredient(name: "Milk", type: IngType.dairy, qty: Quantity(amt: 1, unit: Unit.gal), img: Image("milk")),
            Ingredient(name: "Cheese", type: IngType.dairy, qty: Quantity(amt: 16, unit: Unit.oz), img: Image("cheese")),
            Ingredient(name: "Lettuce", type: IngType.fnv, qty: Quantity(amt: 1, unit: Unit.unit), img: Image("lettuce")),
            Ingredient(name: "Pasta", type: IngType.grains, qty: Quantity(amt: 8, unit: Unit.oz), img: Image("pasta")),
            Ingredient(name: "Apple", type: IngType.fnv, qty: Quantity(amt: 2, unit: Unit.unit), img: Image("apple")),
            Ingredient(name: "Ground Beef", type: IngType.protein, qty: Quantity(amt: 2, unit: Unit.lb), img: Image("gbeef"))
        ]
        
        
    }
    static func getIngredient() -> [Ingredient] {
        return Ingredient.data
    }
    
    
}



