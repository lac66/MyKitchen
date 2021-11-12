//
//  Ingredient.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import Foundation
import SwiftUI

class Ingredient: Identifiable {
    let id : String
    let text : String
    var quantity : Double
    var measure : String?
    let food : String
    let weight : Double
    let foodCategory: String?
    let imgUrl: String?
    
    var type: IngType?
    var img: UIImage?
    
    init(id: String, text: String, quantity: Double, measure: String?, food: String, weight: Double, foodCategory: String?, imgUrl: String?) {
        self.id = id
        self.text = text
        self.quantity = quantity
        self.measure = measure
        self.food = food
        self.weight = weight
        self.foodCategory = foodCategory
        self.imgUrl = imgUrl
    }
}


//extension Ingredient {
//    static var data: [Ingredient] {
//        [
//            Ingredient(name: "Milk", type: IngType.dairy, qty: Quantity(amt: 1, unit: Unit.gal), img: Image("milk")),
//            Ingredient(name: "Cheese", type: IngType.dairy, qty: Quantity(amt: 16, unit: Unit.oz), img: Image("milk")),
//            Ingredient(name: "Lettuce", type: IngType.fnv, qty: Quantity(amt: 1, unit: Unit.unit), img: Image("milk")),
//            Ingredient(name: "Pasta", type: IngType.grains, qty: Quantity(amt: 8, unit: Unit.oz), img: Image("milk")),
//            Ingredient(name: "Apple", type: IngType.fnv, qty: Quantity(amt: 2, unit: Unit.unit), img: Image("milk")),
//            Ingredient(name: "Ground Beef", type: IngType.protein, qty: Quantity(amt: 2, unit: Unit.lb), img: Image("milk"))
//        ]
//
//
//    }
//    static func getIngredient() -> [Ingredient] {
//        return Ingredient.data
//    }
//
//
//}



