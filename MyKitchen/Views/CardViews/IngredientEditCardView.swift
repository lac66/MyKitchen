//
//  IngredientEditCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//





//
//
//
//                  todo
//
//                  Ingredient object does not update with picker atm
//
//
//
//
//

import SwiftUI

struct IngredientEditCardView: View {
    
    init(ingredient : Ingredient) {
        self._ingredient = State(initialValue: ingredient)
//        self._selectedUnit = State(initialValue: Unit.allCases.firstIndex(of: ingredient.qty!.getUnit())!)
    }
    
    @State var ingredientQtyInput : String = ""
//    @State var selectedUnit : Int
    @State var ingredient: Ingredient
    
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
//                Text(ingredient.name)
//                    .frame(width: 210, height: 30, alignment: .leading)
//                    .padding(.leading, 10)
//                    .background(Color("MintCream"))
//                    .foregroundColor(Color("OxfordBlue"))
                
                HStack (spacing: 0) {
                    Button {
//                        ingredient.qty!.decrementAmt()
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
//                    let amtText: String = String(format: "%.2f", ingredient.qty!.getAmt())
//                    Text(amtText)
//                        .frame(width: 50, height: 20)
//                        .background(Color("MintCream"))
//                        .foregroundColor(Color("OxfordBlue"))
                    
                    Button {
//                        ingredient.qty!.incrementAmt()
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                    
//                    Picker(selection: $selectedUnit, label: Text(Unit.allCases[selectedUnit].str).foregroundColor(Color("OxfordBlue")),
//                           content: {
//                            ForEach(0 ..< Unit.allCases.count) { index in
//                                Text(Unit.allCases[index].str)
//                                .frame(width: 80, height: 25)
//                                .foregroundColor(Color("OxfordBlue"))
//                        }
//                    })
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80, height: 25, alignment: .center)
                    .background(Color("MintCream"))
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
//                        print(ingredient.qty!.getUnit())
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
    static var ingredient = Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "imgUrl")
    static var previews: some View {
        IngredientEditCardView(ingredient: ingredient)
            .previewLayout(.fixed(width: 350, height: 90))
    }
}

