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
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    @State var ingredientQtyInput : String = ""
    //    @State var selectedUnit : Int
    
    let ingredient: Ingredient
    
    init(ingredient : Ingredient, withURL url: String?) {
        self.ingredient = ingredient
//        self._selectedUnit = State(initialValue: Unit.allCases.firstIndex(of: ingredient.qty!.getUnit())!)
        if (url == nil) {
            imageLoader = ImageLoader(urlString: "")
        } else {
            imageLoader = ImageLoader(urlString: url!)
        }
    }
    
//    var editingChanged: (Bool)->() = { _ in }
//    var commit: ()->() = {}
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .cornerRadius(6)
                    .onReceive(imageLoader.didChange) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                        self.ingredient.img = self.image
                    }
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text(ingredient.food)
//                Text(ingredient.foodCategory!)
                    .frame(width: 210, height: 30, alignment: .leading)
                    .padding(.leading, 10)
                    .background(Color("MintCream"))
                    .foregroundColor(Color("OxfordBlue"))
                    .padding(.bottom, 5)
                
                HStack (spacing: 0) {
                    Button {
//                        ingredient.qty!.decrementAmt()
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                    let amtText: String = String(format: "%.2f", ingredient.quantity)
                    Text(amtText)
                        .frame(width: 50, height: 20)
                        .background(Color("MintCream"))
                        .foregroundColor(Color("OxfordBlue"))
                    
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
//                    .pickerStyle(MenuPickerStyle())
                    
                    if (ingredient.foodCategory != nil) {
                        Text(ingredient.foodCategory!)
                            .frame(width: 80, height: 25, alignment: .center)
                            .background(Color("MintCream"))
                            .foregroundColor(Color("OxfordBlue"))
                            .padding(.leading)
                    }
                    
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
    static var ingredient = Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg")
    static var previews: some View {
        IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl!)
            .previewLayout(.fixed(width: 350, height: 90))
    }
}

