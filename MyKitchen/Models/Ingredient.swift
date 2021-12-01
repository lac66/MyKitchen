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
    
    var unit: CustomUnit?
    var type: IngType?
    var img: UIImage?
    var qty: Quantity?
    
    init(id: String, text: String, quantity: Double, measure: String?, food: String, weight: Double, foodCategory: String?, imgUrl: String?) {
        self.id = id
        self.text = text
        self.quantity = quantity
        self.measure = measure
        self.food = food
        self.weight = weight
        self.foodCategory = foodCategory
        self.imgUrl = imgUrl
        
        self.unit = getUnits(unitStr: measure)
        self.qty = Quantity(amt: quantity, unit: getUnits(unitStr: measure))
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
    
    func getUnits(unitStr: String?) -> CustomUnit {
        if (unitStr == nil) {
            return CustomUnit.unit
        }
        
        let tmp = unitStr!.lowercased()
        if tmp == "pound" || tmp == CustomUnit.lb.str {
            return CustomUnit.lb
        } else if tmp == "ounce" || tmp == CustomUnit.oz.str {
            return CustomUnit.oz
        } else if tmp == "teaspoon" || tmp == CustomUnit.tsp.str {
            return CustomUnit.tsp
        } else if tmp == "tablespoon" || tmp == CustomUnit.Tbsp.str {
            return CustomUnit.Tbsp
        } else if tmp == "fluid ounce" || tmp == CustomUnit.fl_oz.str {
            return CustomUnit.fl_oz
        } else if tmp == "cup" || tmp == CustomUnit.cup.str {
            return CustomUnit.cup
        } else if tmp == "pint" || tmp == CustomUnit.pt.str {
            return CustomUnit.pt
        } else if tmp == "quart" || tmp == CustomUnit.qt.str {
            return CustomUnit.qt
        } else if tmp == "gallon" || tmp == CustomUnit.gal.str {
            return CustomUnit.gal
        } else if tmp == "milligram" || tmp == CustomUnit.mg.str {
            return CustomUnit.mg
        } else if tmp == "gram" || tmp == CustomUnit.g.str {
            return CustomUnit.g
        } else if tmp == "kilogram" || tmp == CustomUnit.kg.str {
            return CustomUnit.kg
        } else if tmp == "milliliter" || tmp == CustomUnit.ml.str {
            return CustomUnit.ml
        } else if tmp == "liter" || tmp == CustomUnit.l.str {
            return CustomUnit.l
        } else {
            return CustomUnit.unit
        }
    }
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return (lhs.id == rhs.id) && (lhs.quantity == rhs.quantity) && (lhs.unit == rhs.unit) && (lhs.measure == rhs.measure) && (lhs.qty == rhs.qty)
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



