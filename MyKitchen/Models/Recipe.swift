//
//  Recipe.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import Foundation
import SwiftUI

struct Recipe : Equatable, Identifiable {
    
    let id : String
    let name: String
    let imgUrl : String?
    let sourceUrl : String?
    let yield : Double
    let ingString : [String]?
    let ingredients : [Ingredient]
    let calories : Double?
    let cuisineType : [String]?
    let mealType : [String]?
    
    let recipeInstructions: String?
    var img : UIImage?
    
    init (id: String, name: String, imgUrl: String?, sourceUrl: String?, yield: Double, ingString: [String]?, ingredients: [Ingredient], calories: Double?, cuisineType: [String]?, mealType: [String]?, recipeInstructions: String?) {
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        self.sourceUrl = sourceUrl
        self.yield = yield
        self.ingString = ingString
        self.ingredients = ingredients
        self.calories = calories
        self.cuisineType = cuisineType
        self.mealType = mealType
        self.recipeInstructions = recipeInstructions
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}
