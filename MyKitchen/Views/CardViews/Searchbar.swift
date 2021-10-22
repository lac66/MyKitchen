//
//  CustomTextView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/22/21.
//

import SwiftUI

struct Searchbar: View {
    let placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = {}
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 6)
            
            ZStack (alignment: .leading) {
                if text.isEmpty { placeholder }
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
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
        Searchbar(placeholder: Text("Search here"), text: $emptyText)
    }
}
