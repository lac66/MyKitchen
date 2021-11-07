//
//  RecipeApiResponse.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/6/21.
//

import Foundation

struct RecipeApiResponse : Codable {
    let from : Int?
    let to : Int?
    let count : Int?
    let _links : Links?
    let hits : [SubRecipeResponse]?
}

struct Links : Codable {
//    let `self` : SubLinks
    let next : SubLinks?
}

struct SubLinks : Codable {
    let href : String?
    let title : String?
}

struct SubRecipeResponse : Codable {
    let recipe : RecipeTest?
    let _links : Links?
}
