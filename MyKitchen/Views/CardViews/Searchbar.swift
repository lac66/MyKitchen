//
//  CustomTextView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/22/21.
//

import SwiftUI

// Example API call for chili
//  var url = "https://api.edamam.com/api/recipes/v2/chili?app_id=" + appId + "&app_key=" + appKey;

struct Searchbar: View {
    let appId = "30587033"
    let appKey = "0febb1f0fdee5debdf144f1318297d2a"
    let firstPartialURL = "https://api.edamam.com/api/recipes/v2/"
//    let lastPartialUrl = "?app_id=\(appId)&app_key=\(appKey)"
    
    let placeholder: Text
    var isForRecipes: Bool
    @Binding var text: String
    
    func searchWithApi(changed: Bool) {
        print("changed")
        if (isForRecipes) {
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

//            self.completeResponse(response: json)
                    
                // Display text to view
                //                    DispatchQueue.main.async {
                //                        var responseString = "["
                //                        for god in json {
                //                            responseString += god.toString() + ","
                //                        }
                //                        responseString += "]"
                //                        self.responseTextView.text = responseString
                //                    }
        })
        
        task.resume()
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 6)
            
            ZStack (alignment: .leading) {
                if text.isEmpty { placeholder }
                TextField("", text: $text, onEditingChanged: self.searchWithApi)
            }
            
            if !text.isEmpty {
                Button {
                    clearText()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 6)
                }
            }
        }
        .frame(width: 350, height: 30)
        .foregroundColor(Color("MintCream"))
        .background(Color("Camel"))
        .cornerRadius(20)
    }
    
    func clearText() {
        text = ""
    }
}

struct Searchbar_Previews: PreviewProvider {
    @State static var emptyText = ""
    
    static var previews: some View {
        Searchbar(placeholder: Text("Search here"), isForRecipes: true, text: $emptyText)
    }
}
