//
//  EdamamInterface.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation

class EdamamInterface : ObservableObject {
    let appId = "30587033"
    let appKey = "0febb1f0fdee5debdf144f1318297d2a"
    let firstPartialURL = "https://api.edamam.com/api/recipes/v2/"
    //    let lastPartialUrl = "?app_id=\(appId)&app_key=\(appKey)"
    
    func searchWithApi(text: String, isForRecipes: Bool) {
        print("changed")
        if (isForRecipes) {
            if (text.isEmpty) {
                return
            }
            
            let url = firstPartialURL + "?type=public&q=\(text)&app_id=\(appId)&app_key=\(appKey)"
            print(url)
            getData(from: url)
        } else {
            // perform ingredient search
        }
    }
    
    func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            print("JSON String: ")
            print("\(String(data: data, encoding: .utf8))")
            
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
            
            print(json)
            
            DispatchQueue.main.async {
                // get recipes to planningview
            }
        })
        
        task.resume()
    }
}
