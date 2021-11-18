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
    let placeholder: Text
    var isForRecipes: Bool
    @Binding var text: String
    @State var typingCheck: DispatchWorkItem?
    
    init(placeholder: String, isForRecipes: Bool, text: Binding<String>) {
        self.placeholder = Text(placeholder)
        self.isForRecipes = isForRecipes
        self._text = text
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 6)
            
            TextField("", text: $text)
                .placeholder(when: text.isEmpty, placeholder: {
                    Text("Search here")
                })
                .frame(height: 30)
            
            if !text.isEmpty {
                Button {
                    clearText()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 6)
                }
            }
        }
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
    @State static var searchBool = true
    
    static var previews: some View {
        Searchbar(placeholder: "Search Here", isForRecipes: true, text: $emptyText)
    }
}
