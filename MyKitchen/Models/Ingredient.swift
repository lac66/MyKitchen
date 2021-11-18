//
//  Ingredient.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import Foundation
import SwiftUI

struct Ingredient: Identifiable, Equatable {
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
        
        if foodCategory != nil {
            self.type = getType(category: foodCategory!)
        }
    }
    
    func getType(category: String) -> IngType {
        let tmp = category.lowercased()
        if tmp == "meats" || tmp == "poultry" || tmp == "eggs" || tmp == "cured meats" {
            return IngType.protein
        } else if tmp == "vegetables" || tmp == "fruit" {
            return IngType.fnv
        } else if tmp == "cheese" || tmp == "dairy" || tmp == "milk" {
            return IngType.dairy
        } else if tmp == "grains" || tmp == "bread, rolls and tortillas" {
            return IngType.grains
        } else if tmp == "cocktails and liquors" || tmp == "liquors and cocktails" || tmp == "water" || tmp == "non-dairy beverages" || tmp == "wines" {
            return IngType.drink
        } else {
            return IngType.misc
        }
    }
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.id == rhs.id
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



