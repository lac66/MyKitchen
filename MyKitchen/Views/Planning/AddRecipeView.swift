//
//  AddRecipeView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/27/21.
//

import SwiftUI

struct AddRecipeView: View {
    let placeholder = Text("Recipe Name")
    let instructionPlaceholder = "Enter instructions here..." //Text("Enter instructions here...")
    @State var nameInput: String = ""
    @State var qtyInput: String = ""
    @State var amtInput: String = ""
    @State var ingredientNameInput: String = ""
    @State var recipeInstructionsInput: String = "Enter instructions here..."
    @State var showAddPanel: Bool = false
    @State var offsetAmt: CGFloat = -80
//    @State var ingredients : [Ingredient] = [Ingredient(name: "Milk", qty: "1 cup"), Ingredient(name: "Ground Beef", qty: "1 lb")]
    @State var ingredients : [Ingredient] = []
    @State var id : Int = 0
    
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = {}
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .green
        UITableView.appearance().backgroundColor = .green
    }
    
    var body: some View {
        ZStack {
            Color("OxfordBlue").ignoresSafeArea()
            
            ScrollView {
                VStack (spacing: 20) {
                    ZStack (alignment: .leading) {
                        if nameInput.isEmpty { placeholder.font(.system(size: 18, weight: .semibold, design: .default)) }
                        TextField("", text: $nameInput, onEditingChanged: editingChanged, onCommit: commit)
                            .navigationBarTitle("Add Recipe", displayMode: .inline)
                    }
                    .padding(.leading)                          //
                    .frame(width: 350, height: 50)              //
                    .foregroundColor(Color("OxfordBlue"))       //  Use this to show padding difference
                    .background(Color("MintCream"))             //
                    .cornerRadius(15)                           //
                    .padding(.top)                              //
                    
                    VStack (spacing: 0) {
                        VStack {
//                            HStack {
//                                Text("Ingredients")
//                                    .font(.system(size: 18, weight: .semibold, design: .default))
//                                    .padding()
//                                Spacer()
//                            }
//
//                            ZStack (alignment: .topLeading) {
//                                if (ingredients.count > 0) {
//                                    List(ingredients) {
//                                        Text("\($0.qty!)    \($0.name)")
//                                    }
//                                    .frame(width: 300)
//                                    .background(Color("MintCream"))
//                                    .foregroundColor(Color("OxfordBlue"))
//                                }
//                            }
//                            .background(Color("MintCream"))
                            
                            Text("Ingredient")
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .padding()

                            if (ingredients.count > 0) {
                                ForEach(ingredients, id: \.id) { ingredient in
                                    Text("\(ingredient.qty!)   \(ingredient.name)")
                                }
                            }
                        }
                        .zIndex(1)
                        .frame(maxWidth: 350, minHeight: 100, alignment: .topLeading)
                        .background(Color("MintCream"))
                        .foregroundColor(Color("OxfordBlue"))
                        .cornerRadius(15)
                        .onTapGesture {
                            if recipeInstructionsInput == "" {
                                recipeInstructionsInput = instructionPlaceholder
                            }
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        ZStack {
                            HStack (alignment: .center) {
                                TextField("", text: $amtInput)
                                    .placeholder(when: amtInput.isEmpty) {
                                        Text("#")
                                            .foregroundColor(Color("OxfordBluePlaceholder"))
                                    }
                                    .padding(.leading)
                                    .frame(width: 50, height: 40)
                                    .background(Color("MintCream"))
                                TextField("", text: $qtyInput)
                                    .placeholder(when: qtyInput.isEmpty) {
                                        Text("QTY")
                                            .foregroundColor(Color("OxfordBluePlaceholder"))
                                    }
                                    .padding(.leading, 5)
                                    .frame(width: 50, height: 40)
                                    .background(Color("MintCream"))
                                    .padding()
                                TextField("", text: $ingredientNameInput)
                                    .placeholder(when: ingredientNameInput.isEmpty) {
                                        Text("Ingredient")
                                            .foregroundColor(Color("OxfordBluePlaceholder"))
                                    }
                                    .padding(.leading)
                                    .frame(width: 150, height: 40)
                                    .background(Color("MintCream"))
                            }
                            .frame(width: 350, height: 100)
                            .foregroundColor(Color("OxfordBlue"))
                            .background(Color("AirBlue"))
                            .multilineTextAlignment(.leading)
                        }
                        .frame(width: 350, height: 100)
                        .zIndex(0)
                        .offset(y: offsetAmt)
                        
                        ZStack {
                            Button {
                                if (showAddPanel) {
                                    ingredients.append(Ingredient(name: ingredientNameInput, qty: (amtInput + " " + qtyInput)))
                                    amtInput = ""
                                    qtyInput = ""
                                    ingredientNameInput = ""
                                    // add to ingredients above
                                    offsetAmt = -80
                                    showAddPanel = false
                                    id += 1
                                } else {
                                    offsetAmt = -20
                                    showAddPanel = true
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Add Ingredients")
                                        .font(.system(size: 28, weight: .semibold, design: .default))
                                }
                                .frame(width: 325, height: 50)
                                .foregroundColor(Color("MintCream"))
                                .background(Color("Camel"))
                                .cornerRadius(30)
                            }
                            .frame(width: 350, height: 60)
                            .background(Color("MintCream"))
                            .cornerRadius(15)
                        }
                        .frame(width: 350, height: 60)
                        .zIndex(1)
                        .offset(y: (offsetAmt - 20))
                        
                    }
                    
                    ZStack {
                        VStack (spacing: 0) {
                            HStack {
                                Text("Instructions")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .padding()
                                Spacer()
                            }
                            
                            ZStack (alignment: .topLeading) {
                                TextEditor(text: $recipeInstructionsInput)
                                    .frame(width: 300)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        if recipeInstructionsInput == instructionPlaceholder {
                                            recipeInstructionsInput = ""
                                        }
                                    }
                            }
                            .background(Color("MintCream"))
                            
                        }
                        .frame(maxWidth: 350, minHeight: 250, alignment: .topLeading)
                        .background(Color("MintCream"))
                        .foregroundColor(Color("OxfordBlue"))
                        .cornerRadius(15)
                    }
                    .offset(y: (offsetAmt - 20))
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 350, height: 80)
                            .foregroundColor(Color("AirBlue"))
                            .cornerRadius(15)
                        
                        HStack {
                            Image(systemName: "tray.and.arrow.down.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("Save Recipe")
                                .font(.system(size: 36, weight: .bold, design: .default))
                        }
                        .frame(width: 300, height: 60)
                        .foregroundColor(Color("MintCream"))
                        .background(Color("Marigold"))
                        .cornerRadius(15)
                    }
                    .offset(y: (offsetAmt - 20))
                }
            }
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddRecipeView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
