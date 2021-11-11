//
//  IngredientTest.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/6/21.
//

import Foundation

struct IngredientApi: Codable {
    let text : String?
    let quantity : Double?
    let measure : String?
    let food : String?
    let weight : Double?
    let foodCategory: String?
    let foodId : String?
    let image: String?
}
