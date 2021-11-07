//
//  RecipeTest.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/6/21.
//

import Foundation

struct RecipeTest : Codable {
    let uri : String?
    let label : String?
    let image : String?
    let source : String?
    let url : String?
    let shareAs : String?
    let yield : Int?
    let dietLabels : [String]?
    let healthLabels : [String]?
    let cautions : [String]?
    let ingredientLines : [String]?
    let ingredients : [IngredientTest]?
    let calories : Double?
    let glycemicIndex : Int?
    let totalCO2Emissions : Int?
    let co2EmissionsClass : String?
    let totalWeight: Int?
    let cuisineType : [String]?
    let mealType : [String]?
    let dishType : [String]?
    let totalNutrients: String?
    let totalDaily : String?
    let digest : Digest?
    
    //    init (uri : String, label : String, image : String, source : String, url : String, shareAs : String, yield : Int, dietLabels : [String], healthLabels : [String], cautions : [String], ingredientLines : [String], ingredients : [Ingredient], calories : Int, glycemicIndex : Int, totalCO2Emissions : Int, co2EmissionsClass : String, totalWeight: Int, cuisineType : [String], mealType : [String], dishType : [String], totalNutrients: String, totalDaily : String, digest : Digest) {
    //        self.uri = url
    //        self.label = label
    //        self.image = image
    //        self.source = source
    //        self.url = url
    //        self.shareAs = shareAs
    //        self.yield = yield
    //        self.dietLabels = dietLabels
    //        self.healthLabels = healthLabels
    //        self.cautions = cautions
    //        self.ingredientLines = ingredientLines
    //        self.ingredients = ingredients
    //        self.calories = calories
    //        self.glycemicIndex = glycemicIndex
    //        self.totalCO2Emissions = totalCO2Emissions
    //        self.co2EmissionsClass = co2EmissionsClass
    //        self.totalWeight = totalWeight
    //        self.cuisineType = cuisineType
    //        self.mealType = mealType
    //        self.dishType = dishType
    //        self.totalNutrients = totalNutrients
    //        self.totalDaily = totalDaily
    //        self.digest = digest
    //    }
}


struct Digest : Codable {
    let label : String?
    let tag : String?
    let schemaOrgTag : String?
    let total : Int?
    let hasRDI : Bool?
    let daily : Int?
    let unit : String?
    let sub : String?
}
