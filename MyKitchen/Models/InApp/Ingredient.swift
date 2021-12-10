//
//  Ingredient.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import Foundation
import SwiftUI

// model for ingredients
struct Ingredient: Identifiable, Equatable {
    // received from api
    let id : String
    let text : String
    var quantity : Double
    var measure : String?
    let food : String
    let weight : Double
    let foodCategory: String?
    let imgUrl: String?
    
    // used for grouping and measures
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
    
    // takes api string and assigns type case
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
        } else if tmp == "cocktails and liquors" || tmp == "liquors and cocktails" || tmp == "water" || tmp == "non-dairy beverages" || tmp == "wines" || tmp == "sweetened beverages" {
            return IngType.drink
        } else {
            return IngType.misc
        }
    }
    
    // takes api string and assigns unit case for conversions
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
        } else if tmp == "tablespoon" || tmp == CustomUnit.Tbsp.str.lowercased() {
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
        return (lhs.id == rhs.id) && (lhs.quantity == rhs.quantity) && (lhs.unit == rhs.unit) && (lhs.qty == rhs.qty)
    }
}



