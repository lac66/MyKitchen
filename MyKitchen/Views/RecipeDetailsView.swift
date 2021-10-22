//
//  RecipeDetailsView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    var pickerSelection = ["Personal List", "Group List"]
    
    @State private var showListSelection = false
    @State private var selectedList = "Personal List"
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color("OxfordBlue").ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack (alignment: .leading) {
                        Text(recipe.name)
                            .navigationBarTitle("Recipe Details", displayMode: .inline)
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .padding(.leading, 25)
                        
                        RecipeDetailsSubView(recipe: recipe)
                    }
                    .foregroundColor(Color("MintCream"))
                }
                
                VStack {
                    Button("Add to List") {
                        if (showListSelection) {
                            // add to list now
                            showListSelection.toggle()
                        } else {
                            showListSelection.toggle()
                        }
                    }
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color("MintCream"))
                    .font(.system(size: 30, weight: .black, design: .monospaced))
                    .background(Color("Camel"))
                    .cornerRadius(24)
                    
                    if showListSelection {
                        VStack {
                            Picker("Choose a list to add recipe to", selection: $selectedList) {
                                ForEach(pickerSelection, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        .foregroundColor(Color("MintCream"))
                        .frame(height: 60)
                    }
                }
                .padding(.bottom, 10)
            }
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var recipe = Recipe.data[0]
    static var previews: some View {
        RecipeDetailsView(recipe: recipe)
    }
}

struct RecipeDetailsSubView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 350)
                .foregroundColor(Color("Camel"))
                .cornerRadius(30)
            
            recipe.img!
                .resizable()
                .frame(width: 325, height: 325)
                .cornerRadius(25)
        }
        
        ZStack (alignment: .leading) {
            Rectangle()
                .frame(width: 350)
                .foregroundColor(Color("AirBlue"))
                .cornerRadius(30)
            
            VStack (alignment: .leading) {
                Text("Ingredients")
                    .padding(.bottom)
                    .font(.system(size: 24, weight: .semibold, design: .default))
                
                ForEach(recipe.ingredients!, id: \.self) { ingredient in
                    Text(ingredient)
                        .padding(1)
                        .padding(.leading)
                }
            }
            .padding(12)
            .padding(.leading, 12)
        }
        
        ZStack (alignment: .leading) {
            Rectangle()
                .frame(width: 350)
                .foregroundColor(Color("AirBlue"))
                .cornerRadius(30)
            
            VStack (alignment: .leading) {
                Text("Instructions")
                    .padding(.bottom)
                    .font(.system(size: 24, weight: .semibold, design: .default))
                
                ForEach(recipe.instructions!, id: \.self) { instructions in
                    Text(instructions)
                        .padding(1)
                        .padding(.leading)
                }
            }
            .padding(12)
            .padding(.leading, 12)
        }
    }
}
