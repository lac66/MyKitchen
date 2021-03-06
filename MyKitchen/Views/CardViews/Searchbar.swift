//
//  CustomTextView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/22/21.
//

import SwiftUI

// searchbar subview
struct Searchbar: View {
    let textPlaceholder: String
    var isForRecipes: Bool
    @Binding var text: String
    
    init(placeholder: String, isForRecipes: Bool, text: Binding<String>) {
        self.textPlaceholder = placeholder
        self.isForRecipes = isForRecipes
        self._text = text
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 6)
            
            TextField("", text: $text)
                .placeholder(when: text.isEmpty, placeholder: {
                    Text(textPlaceholder)
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
