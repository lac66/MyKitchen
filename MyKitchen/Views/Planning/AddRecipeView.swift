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
    
    @State var showAddButton: Bool = true
    @State var ingredientSearchText = ""
    @State var typingCheck: DispatchWorkItem?
    
    let instructionPlaceholder = "Enter instructions here..."
    @State var recipeInstructionsInput: String = "Enter instructions here..."
    
    @State var errorMsg: String = ""
    @State var hasErrorSaveRecipe: Bool = false
    
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
                            
                            if showAddButton {
                                Button {
                                    showAddButton.toggle()
                                } label: {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("Add Ingredients")
                                            .font(.system(size: 24, weight: .semibold, design: .default))
                                    }
                                    .frame(width: 325, height: 40)
                                    .foregroundColor(Color("MintCream"))
                                    .background(Color("Camel"))
                                    .cornerRadius(30)
                                }
                                .frame(width: 350, height: 40)
                                .padding(.bottom, 10)
                            } else {
                                VStack {
                                    Searchbar(placeholder: "Search Ingredients", isForRecipes: false, text: $ingredientSearchText)
                                        .frame(width: 330)
                                        .padding(.top, 5)
                                        .onChange(of: ingredientSearchText) { newValue in
                                            if (typingCheck != nil) {
                                                typingCheck!.cancel()
                                                typingCheck = nil
                                            }
                                            
                                            typingCheck = DispatchWorkItem {
                                                print("search")
                                                eInterface.searchWithApi(text: ingredientSearchText, isForRecipes: false)
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: typingCheck!)
                                        }
                                    
                                    ScrollView {
                                        VStack {
                                            ForEach(eInterface.ingredients, id: \.id) { ingredient in
                                                AddRecipeIngredientCardView(ingredient: ingredient, withURL: ingredient.imgUrl)
                                                    .padding(5)
                                            }
                                        }
                                    }
                                }
                                .onDisappear() {
                                    eInterface.ingredients.removeAll()
                                }
                                .onChange(of: eInterface.selectedIngredient) { newValue in
                                    ingredients.append(eInterface.selectedIngredient!)
                                    eInterface.ingredients.removeAll()
                                    ingredientSearchText = ""
                                    showAddButton.toggle()
                                }
                                .frame(width: 340)
                                .padding(.leading, 5)
                            }
                        }
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
                    }
                    
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
