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
    @EnvironmentObject var eInterface : EdamamInterface
    
    let placeholder: Text
    var isForRecipes: Bool
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 6)
            
            ZStack (alignment: .leading) {
                if text.isEmpty { placeholder }
                TextField("", text: $text, onEditingChanged: self.search)
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
    
    func search(changed: Bool) {
        eInterface.searchWithApi(text: text, isForRecipes: isForRecipes)
    }
}

struct Searchbar_Previews: PreviewProvider {
    @State static var emptyText = ""
    
    static var previews: some View {
        Searchbar(placeholder: Text("Search here"), isForRecipes: true, text: $emptyText)
    }
}
