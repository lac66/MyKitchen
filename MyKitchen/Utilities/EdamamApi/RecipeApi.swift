//
//  RecipeTest.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/6/21.
//

import Foundation

struct RecipeApi : Codable {
    let uri : String?
    let label : String?
    let image : String?
    let source : String?
    let url : String?
    let shareAs : String?
    let yield : Double?
    let dietLabels : [String]?
    let healthLabels : [String]?
    let cautions : [String]?
    let ingredientLines : [String]?
    let ingredients : [IngredientApi]?
    let calories : Double?
    let glycemicIndex : Int?
    let totalCO2Emissions : Int?
    let co2EmissionsClass : String?
    let totalWeight: Double?
    let cuisineType : [String]?
    let mealType : [String]?
    let dishType : [String]?
    let totalNutrients: [String: Nutrient]?
    let totalDaily : [String: Nutrient]?
    let digest : [Digest]?
    
    let recipeInstructions: String?
}

struct Nutrient : Codable {
    let label: String
    let quantity: Double
    let unit : String
    
}

struct Digest : Codable {
    let label : String?
    let tag : String?
    let schemaOrgTag : String?
    let total : Double?
    let hasRDI : Bool?
    let daily : Double?
    let unit : String?
    let sub : [Digest]?
}
