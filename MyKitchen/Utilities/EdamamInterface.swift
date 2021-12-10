//
//  EdamamInterface.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import SwiftUI

// interface for edamam api
class EdamamInterface : ObservableObject {
    let recipeAppId = "30587033"
    let recipeAppKey = "0febb1f0fdee5debdf144f1318297d2a"
    let firstPartialURLRecipe = "https://api.edamam.com/api/recipes/v2/"
    
    @Published var recipes : [Recipe] = []
    @Published var ingredients : [Ingredient] = []
    @Published var selectedIngredient: Ingredient? = nil
    
    // choose which data to retrieve, recipe or ingredient
    func searchWithApi(text: String, isForRecipes: Bool) {
        if (text.isEmpty) {
            return
        }
        
        let newText = text.replacingOccurrences(of: " ", with: "+")
        let url = firstPartialURLRecipe + "?type=public&q=\(newText)&app_id=\(recipeAppId)&app_key=\(recipeAppKey)"
        
        if (isForRecipes) {
            getRecipeData(from: url)
        } else {
            getIngredientData(from: url, searchText: text)
        }
    }
    
    // get recipes from api
    func getRecipeData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
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
    
    // get ingredients from api
    func getIngredientData(from url: String, searchText: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
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
            
            DispatchQueue.main.async {
                self.ingredients.removeAll()
            }
            
            var ingArr: [Ingredient] = []
            
            for subRecipe in json.hits! {
                let tmp = subRecipe.recipe!
                let searchTextLower = searchText.lowercased()
                
                for ing in tmp.ingredients! {
                    if ing.food!.contains(searchTextLower) {
                        var addIng = true
                        let newIngredient = Ingredient(id: ing.foodId!, text: ing.text!, quantity: ing.quantity!, measure: ing.measure, food: ing.food!, weight: ing.weight!, foodCategory: ing.foodCategory, imgUrl: ing.image)
                        
                        for oldIng in ingArr {
                            if oldIng.id == newIngredient.id {
                                addIng = false
                                break
                            }
                        }
                        if addIng {
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
    }
}
