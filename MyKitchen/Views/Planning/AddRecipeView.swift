//
//  AddRecipeView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/27/21.
//

import SwiftUI

struct AddRecipeView: View {
    @EnvironmentObject var eInterface: EdamamInterface
    
    let instructionPlaceholder = "Enter instructions here..." //Text("Enter instructions here...")
    @State var nameInput: String = ""
    @State var selectedQty: Int = 14
    @State var amtInput: String = ""
    @State var ingredientNameInput: String = ""
    @State var recipeInstructionsInput: String = "Enter instructions here..."
    @State var errorMsg: String = ""
    @State var showAddPanel: Bool = false
    @State var hasError: Bool = false
    @State var offsetAmt: CGFloat = -80
    @State var ingredients : [Ingredient] = []
    
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
                    TextField("", text: $nameInput)
                        .navigationBarTitle("Add Recipe", displayMode: .inline)
                        .placeholder(when: nameInput.isEmpty, placeholder: {
                            Text("Recipe Name")
                        })
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

                            if (ingredients.count > 0) {
                                VStack (alignment: .leading) {
                                    ForEach(ingredients, id: \.id) { ingredient in
                                        Text("\(ingredient.food)")
                                            .padding(.leading, 25)
                                    }
                                    .padding(.bottom, 1)
                                }
                                .padding(.bottom)
                            }
                            
                            if (hasError) {
                                Text(errorMsg)
                                    .frame(width: 350, alignment: .center)
                                    .foregroundColor(Color.red)
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
                                       label: Text(CustomUnit.allCases[selectedQty].str)
                                        .foregroundColor(Color("OxfordBluePlaceholder")),
                                       content: {
                                            ForEach(0 ..< CustomUnit.allCases.count) { index in
                                                Text(CustomUnit.allCases[index].str)
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
                                    if (amtInput.isEmpty && ingredientNameInput.isEmpty) {
                                        selectedQty = 14
                                        showAddPanel = false
                                        offsetAmt = -80
                                        return;
                                    }
                                    let tmpAmtInput = Double(amtInput)
                                    if (tmpAmtInput == nil) {
                                        errorMsg = "Quantity input must be a number"
                                        hasError = true
                                    } else if (ingredientNameInput.isEmpty) {
                                        errorMsg = "Ingredient name must have a value"
                                        hasError = true
                                    } else {
                                        eInterface.searchWithApi(text: ingredientNameInput, isForRecipes: false)
                                        // add to ingredients above
                                        offsetAmt = -80
                                        hasError = false
                                        showAddPanel = false
                                    }
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
                        
                        Button {
                            
                        } label: {
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
                    }
                    .offset(y: (offsetAmt - 20))
                }
            }
        }
        .onChange(of: eInterface.ingredients) { newValue in
            if (!ingredientNameInput.isEmpty) {
                for ing in eInterface.ingredients {
                    if ing.food.lowercased() == ingredientNameInput.lowercased() {
                        ingredients.append(Ingredient(id: ing.id, text: ing.text, quantity: Double(amtInput)!, measure: CustomUnit.allCases[selectedQty].str, food: ing.food, weight: ing.weight, foodCategory: ing.foodCategory, imgUrl: ing.imgUrl))
                        amtInput = ""
                        selectedQty = 14
                        ingredientNameInput = ""
                        eInterface.ingredients.removeAll()
                        return
                    }
                }
                hasError = true
                errorMsg = "Ingredient not found"
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
