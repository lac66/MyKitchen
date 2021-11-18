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
    let imgUrl : String
    let sourceUrl : String
    let yield : Double
    let ingString : [String]
    let ingredients : [Ingredient]
    let calories : Double
    let cuisineType : [String]
    let mealType : [String]
    
    var img : UIImage?
    
    init (id: String, name: String, imgUrl: String, sourceUrl: String, yield: Double, ingString: [String], ingredients: [Ingredient], calories: Double, cuisineType: [String], mealType: [String]) {
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
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}

//extension Recipe {
//    static var data: [Recipe] {
//        [
//            Recipe(id: 1, name: "Chili", cookTime: "1 hour", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 2, name: "Chicken Parmesan", cookTime: "45 mins", difficulty: "Medium", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 3, name: "Brownies", cookTime: "50 mins", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 4, name: "Hamburger", cookTime: "30 mins", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 5, name: "Pizza", cookTime: "2 hours", difficulty: "Medium", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 6, name: "Sushi", cookTime: "20 mins", difficulty: "Hard", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 7, name: "Shrimp Boil", cookTime: "50 mins", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 8, name: "Chicken Parmesan", cookTime: "45 mins", difficulty: "Medium", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 9, name: "Brownies", cookTime: "50 mins", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 10, name: "Hamburger", cookTime: "30 mins", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 11, name: "Pizza", cookTime: "2 hours", difficulty: "Medium", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 12, name: "Sushi", cookTime: "20 mins", difficulty: "Hard", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"]),
//            Recipe(id: 13, name: "Shrimp Boil", cookTime: "50 mins", difficulty: "Easy", img: Image("food"), ingredients: ["1 Cup Something", "2 tsp Something else", "3 Gal Something good"], instructions: ["Put all ingredients in a pan", "Stir until it smells and looks good", "Take pan off of burner", "Enjoy!"])
//        ]
//    }
//
//    static func getRecipes() -> [Recipe] {
//        return Recipe.data
//    }
//}
