//
//  AddRecipeView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/27/21.
//

import SwiftUI
import ToastViewSwift

struct AddRecipeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var eInterface: EdamamInterface
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    @State var nameInput: String = ""
    @State var yieldInput: String = ""
    
    @State var selectedQty: Int = 14
    @State var amtInput: String = ""
    @State var ingredientNameInput: String = ""
    
    let instructionPlaceholder = "Enter instructions here..."
    @State var recipeInstructionsInput: String = "Enter instructions here..."
    
    @State var errorMsg: String = ""
    @State var hasErrorAddIngredient: Bool = false
    @State var hasErrorSaveRecipe: Bool = false
    
    @State var showAddPanel: Bool = false
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
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .padding(.leading)
                        .frame(width: 350, height: 50)
                        .foregroundColor(Color("OxfordBluePlaceholder"))
                        .background(Color("MintCream"))
                        .cornerRadius(15)
                        .padding(.top)
                    
                    TextField("", text: $yieldInput)
                        .placeholder(when: yieldInput.isEmpty, placeholder: {
                            Text("Yield Amount")
                        })
                        .padding(.leading)
                        .frame(width: 350, height: 50)
                        .foregroundColor(Color("OxfordBluePlaceholder"))
                        .background(Color("MintCream"))
                        .cornerRadius(15)
                    
                    VStack (spacing: 0) {
                        VStack (alignment: .leading) {
                            Text("Ingredient")
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .padding()

                            if (ingredients.count > 0) {
                                VStack (alignment: .leading) {
                                    ForEach(ingredients, id: \.id) { ingredient in
                                        let amtText: String = String(format: "%.2f", ingredient.quantity)
                                        HStack {
                                            Text(amtText)
                                                .frame(width: 60, alignment: .trailing)
                                            Text(ingredient.unit!.str)
                                                .frame(width: 50, alignment: .leading)
                                            Text(ingredient.food)
                                            Spacer()
                                            Button {
                                                ingredients.remove(at: ingredients.firstIndex(of: ingredient)!)
                                            } label: {
                                                Image(systemName: "xmark.app.fill")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color.red)
                                            }
                                            .padding(.trailing)
                                        }
                                        .padding(.leading, 25)
                                    }
                                    .padding(.bottom, 1)
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
                                        hasErrorAddIngredient = true
                                    } else if (tmpAmtInput! < 0) {
                                        errorMsg = "Quantity input must be positive number"
                                    } else if (ingredientNameInput.isEmpty || ingredientNameInput == " ") {
                                        errorMsg = "Ingredient name must have a value"
                                        hasErrorAddIngredient = true
                                    } else {
                                        eInterface.searchWithApi(text: ingredientNameInput, isForRecipes: false)
                                        offsetAmt = -80
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
                            .alert(isPresented: $hasErrorAddIngredient) {
                                Alert(title: Text("Add Ingredient Error"), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
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
                                    .foregroundColor(Color("OxfordBluePlaceholder"))
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
                            let tmpYieldInput = Double(yieldInput)
                            if (nameInput.isEmpty) {
                                errorMsg = "Recipe name must have a value"
                                hasErrorSaveRecipe = true
                            } else if (tmpYieldInput == nil) {
                                errorMsg = "Yield input must be a number"
                                hasErrorSaveRecipe = true
                            } else if (tmpYieldInput! < 0) {
                                errorMsg = "Yield input must be a positive number"
                                hasErrorSaveRecipe = true
                            } else if (ingredients.count == 0) {
                                errorMsg = "Recipe must have ingredients"
                                hasErrorSaveRecipe = true
                            } else if (recipeInstructionsInput.isEmpty) {
                                errorMsg = "Recipe instructions must have a value"
                                hasErrorSaveRecipe = true
                            } else {
                                let newRecipe = Recipe(id: UUID().uuidString, name: nameInput, imgUrl: nil, sourceUrl: nil, yield: tmpYieldInput!, ingString: nil, ingredients: ingredients, calories: nil, cuisineType: nil, mealType: nil, recipeInstructions: recipeInstructionsInput)
                                fbInterface.saveRecipe(recipe: newRecipe)
                                let toast = Toast.text("Recipe Saved")
                                toast.show()
                                self.presentationMode.wrappedValue.dismiss()
                            }
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
                        .alert(isPresented: $hasErrorSaveRecipe) {
                            Alert(title: Text("Save Recipe Error"), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
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
                print("no ingredient")
                errorMsg = "Ingredient not found"
                hasErrorAddIngredient = true
                amtInput = ""
                selectedQty = 14
                ingredientNameInput = ""
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
