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
    @State var selectedQty: Int = 14
    @State var amtInput: String = ""
    @State var ingredientNameInput: String = ""
    @State var recipeInstructionsInput: String = "Enter instructions here..."
    @State var showAddPanel: Bool = false
    @State var offsetAmt: CGFloat = -80
    @State var id : Int = 0
    @State var ingredients : [Ingredient] = []
    
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = {}
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .green
        UITableView.appearance().backgroundColor = UIColor(named: "OxfordBlue")
        
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "MintCream") as Any]
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
                    .padding(.leading)
                    .frame(width: 350, height: 50)
                    .foregroundColor(Color("OxfordBlue"))
                    .background(Color("MintCream"))
                    .cornerRadius(15)
                    .padding(.top)
                    
                    VStack (spacing: 0) {
                        VStack (alignment: .leading) {
                            Text("Ingredient")
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .padding()
                                .multilineTextAlignment(.leading)

                            if (ingredients.count > 0) {
                                VStack {
                                    ForEach(ingredients, id: \.id) { ingredient in
//                                        Text("\(ingredient.qty!.toString())     \(ingredient.name)")
//                                            .padding(.leading, 25)
                                    }
                                    .padding(.bottom, 1)
                                    .multilineTextAlignment(.leading)
                                }
                                .padding(.bottom)
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
                                
                                
                                Picker(selection: $selectedQty,
                                       label: Text(Unit.allCases[selectedQty].str)
                                        .foregroundColor(Color("OxfordBluePlaceholder")),
                                       content: {
                                            ForEach(0 ..< Unit.allCases.count) { index in
                                                Text(Unit.allCases[index].str)
                                                    .frame(width: 80, height: 25)
                                                    .foregroundColor(Color("OxfordBlue"))
                                            }
                                        })
                                    .pickerStyle(MenuPickerStyle())
                                    .frame(width: 50, height: 40, alignment: .center)
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
//                                    ingredients.append(Ingredient(name: ingredientNameInput, qty: Quantity(amt: Double(amtInput)!, unit: Unit.allCases[selectedQty])))
                                    amtInput = ""
                                    selectedQty = 14
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
