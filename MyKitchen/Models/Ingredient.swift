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
    let quantity : Double
    let measure : String?
    let food : String
    let weight : Double
    let foodCategory: String?
    let imgUrl: String?
    
    var type: IngType?
    var img: Image?
    
    init(id: String, text: String, quantity: Double, measure: String?, food: String, weight: Double, foodCategory: String?, imgUrl: String?) {
        self.id = id
        self.text = text
        self.quantity = quantity
        self.measure = measure
        self.food = food
        self.weight = weight
        self.foodCategory = foodCategory
        self.imgUrl = imgUrl
        
//        if (imgUrl != nil) {
//            self.getImage(urlStr: imgUrl!)
//        }
    }
    
//    func getImage(urlStr: String) {
//        let url = URL(string: urlStr)
//
//        _ = URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url!.lastPathComponent)
//            print("Download Finished")
//
//            self.img = Image(uiImage: UIImage(data: data)!)
//        }
//    }
}


extension Ingredient {
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
    
}



