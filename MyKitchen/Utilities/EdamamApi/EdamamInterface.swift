//
//  EdamamInterface.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import SwiftUI

class EdamamInterface : ObservableObject {
    let recipeAppId = "30587033"
    let recipeAppKey = "0febb1f0fdee5debdf144f1318297d2a"
    let firstPartialURLRecipe = "https://api.edamam.com/api/recipes/v2/"
    
    let ingredientAppId = "de31f580"
    let ingredientAppKey = "8c5f7874b4568e4204cd01f0def5070b"
    let firstPartialURLIngredient = "https://api.edamam.com/api/food-database/v2/parser"
    //    let lastPartialUrl = "?app_id=\(appId)&app_key=\(appKey)"
    
    @Published var recipes : [Recipe] = []
    @Published var ingredients : [Ingredient] = []
//    @Published var addIngredient: Ingredient? = nil
    
    func searchWithApi(text: String, isForRecipes: Bool) {
        print("search called")
        if (text.isEmpty) {
            return
        }
        
        let newText = text.replacingOccurrences(of: " ", with: "+")
        
        let url = firstPartialURLRecipe + "?type=public&q=\(newText)&app_id=\(recipeAppId)&app_key=\(recipeAppKey)"
//        print(url)
        
        if (isForRecipes) {
            getRecipeData(from: url)
        } else {
            getIngredientData(from: url, searchText: text)
        }
    }
    
    func getRecipeData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
//            print("JSON String: ")
//            print("\(String(data: data, encoding: .utf8))")
            
            var result: RecipeApiResponse?
            
            do {
                result = try JSONDecoder().decode(RecipeApiResponse?.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
                print(String(describing: error))
            }
            
            guard let json = result else {
                return
            }
            
//            print(json)
            
            DispatchQueue.main.async {
                self.recipes.removeAll()
            }
            
            for subRecipe in json.hits! {
                let tmp = subRecipe.recipe!
                
                var newIngredients : [Ingredient] = []
                for ing in tmp.ingredients! {
                    newIngredients.append(Ingredient(id: ing.foodId!, text: ing.text!, quantity: ing.quantity!, measure: ing.measure, food: ing.food!, weight: ing.weight!, foodCategory: ing.foodCategory, imgUrl: ing.image))
                }
                
                let newRecipe = Recipe(id: tmp.uri!, name: tmp.label!, imgUrl: tmp.image!, sourceUrl: tmp.url!, yield: tmp.yield!, ingString: tmp.ingredientLines!, ingredients: newIngredients, calories: tmp.calories!, cuisineType: tmp.cuisineType!, mealType: tmp.mealType!, recipeInstructions: nil)
                
                DispatchQueue.main.async {
                    self.recipes.append(newRecipe)
                }
            }
            
        })
        
        task.resume()
    }
    
    func getIngredientData(from url: String, searchText: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
//            print("JSON String: ")
//            print("\(String(data: data, encoding: .utf8))")
            
            var result: RecipeApiResponse?
            
            do {
                result = try JSONDecoder().decode(RecipeApiResponse?.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
                print(String(describing: error))
            }
            
            guard let json = result else {
                return
            }
            
//            print(json)
            
            DispatchQueue.main.async {
                self.ingredients.removeAll()
            }
            
            var ingArr: [Ingredient] = []
            
            for subRecipe in json.hits! {
                let tmp = subRecipe.recipe!
                let searchTextLower = searchText.lowercased()
                
                for ing in tmp.ingredients! {
                    if ing.food!.contains(searchTextLower) {
                        let newIngredient = Ingredient(id: ing.foodId!, text: ing.text!, quantity: ing.quantity!, measure: ing.measure, food: ing.food!, weight: ing.weight!, foodCategory: ing.foodCategory, imgUrl: ing.image)
                        
                        if !ingArr.contains(newIngredient) {
                            ingArr.append(newIngredient)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                for ing in ingArr {
                    self.ingredients.append(ing)
                }
            }
        })
        
        task.resume()
        print("check")
        self.objectWillChange.send()
    }
    
    func getIngredientForAdd(from url: String, searchText: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            //            print("JSON String: ")
            //            print("\(String(data: data, encoding: .utf8))")
            
            var result: RecipeApiResponse?
            
            do {
                result = try JSONDecoder().decode(RecipeApiResponse?.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
                print(String(describing: error))
            }
            
            guard let json = result else {
                return
            }
            
            //            print(json)
            
            DispatchQueue.main.async {
                self.ingredients.removeAll()
            }
            
            var ingArr: [Ingredient] = []
            
            for subRecipe in json.hits! {
                let tmp = subRecipe.recipe!
                let searchTextLower = searchText.lowercased()
                
                for ing in tmp.ingredients! {
                    if ing.food!.contains(searchTextLower) {
                        let newIngredient = Ingredient(id: ing.foodId!, text: ing.text!, quantity: ing.quantity!, measure: ing.measure, food: ing.food!, weight: ing.weight!, foodCategory: ing.foodCategory, imgUrl: ing.image)
                        
                        if !ingArr.contains(newIngredient) {
                            ingArr.append(newIngredient)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                for ing in ingArr {
                    self.ingredients.append(ing)
                }
                //                print(self.ingredients)
            }
        })
        
        task.resume()
    }
}
