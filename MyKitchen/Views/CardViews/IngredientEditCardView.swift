//
//  IngredientEditCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct IngredientEditCardView: View {
    
    init(ingredient : Ingredient) {
        self.ingredient = ingredient
        self._selectedQty = State(initialValue: self.ingredient.qty!)
    }
    
    @State var ingredientQtyInput : String = ""
    @State var selectedQty : Quantity
    let ingredient: Ingredient
    
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = {}
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                ingredient.img!
                    .resizable()
                    .frame(width: 65, height: 65)
                    .cornerRadius(6)
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text(ingredient.name)
                    .frame(width: 210, alignment: .leading)
                    .padding(.leading, 10)
                    .background(Color("MintCream"))
                    .foregroundColor(Color("OxfordBlue"))
                
                HStack (spacing: 0) {
                    Button {
                        
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                    
                    Text("\(ingredient.qty!.amt)")
                        .frame(width: 30, height: 20)
                        .background(Color("MintCream"))
                        .foregroundColor(Color("OxfordBlue"))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                    
                    Picker("Choose a list to add recipe to", selection: $selectedQty) {
                        ForEach(Unit.allCases, id: \.id) { unit in
                            Text(unit.str)
                        }
                    }
                    
//                    TextField("", text: $ingredientQtyInput, onEditingChanged: editingChanged, onCommit: commit)
//                        .frame(width: 60)
//                        .background(Color("MintCream"))
//                        .padding(.leading)
//                        .placeholder(when: ingredientQtyInput.isEmpty) {
//                            Text(ingredientQty[1])
//                                .foregroundColor(Color("OxfordBluePlaceholder"))
//                                .padding(.leading)
//                        }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(2)
                            .foregroundColor(Color("MintCream"))
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                    .frame(alignment: .trailing)
                    .padding(.trailing)
                    
                }
            }
            .padding(.leading, 15)
            
            Spacer()
        }
        .frame(width: 350, height: 90)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(8)
    }
}

struct IngredientEditCardView_Previews: PreviewProvider {
    static var ingredient = Ingredient.data[0]
    static var previews: some View {
        IngredientEditCardView(ingredient: ingredient)
            .previewLayout(.fixed(width: 350, height: 90))
    }
}

