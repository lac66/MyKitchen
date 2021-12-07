//
//  IngredientEditCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//


import SwiftUI
import ToastViewSwift

struct IngredientEditCardView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    @State var ingredientQtyInput : String = ""
    @State var trashOrAdd: String
    @State var selectedUnit : Int
    @State var tmpAmt : Double
    @State var tmpSelectedUnit: Int
    
    let isPersonalList: Bool
    let ingredient: Ingredient
    
    init(ingredient : Ingredient, withURL url: String?, trashOrAdd: String, isPersonalList: Bool) {
        self.ingredient = ingredient
        self.tmpAmt = ingredient.quantity
        self.tmpSelectedUnit = CustomUnit.allCases.firstIndex(of: ingredient.unit!)!
        self.trashOrAdd = trashOrAdd
        self.isPersonalList = isPersonalList
        self._selectedUnit = State(initialValue: CustomUnit.allCases.firstIndex(of: ingredient.unit!)!)
        if (url == nil) {
            imageLoader = ImageLoader(urlString: "")
        } else {
            imageLoader = ImageLoader(urlString: url!)
        }
//        print("Updating ingredient card named \(ingredient.food) qty \(ingredient.qty!)")
    }
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                if (ingredient.imgUrl != nil) {
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: URL(string: ingredient.imgUrl!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 65, height: 65)
                        .cornerRadius(6)
                    } else {
                        // Fallback on earlier versions
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 65, height: 65)
                            .cornerRadius(6)
                            .onReceive(imageLoader.didChange) { data in
                                self.image = UIImage(data: data) ?? UIImage()
                            }
                    }
                } else {
                    Text("No Image Found")
                        .frame(width: 65, height: 65)
                        .cornerRadius(6)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text(ingredient.food)
                    .frame(width: 210, height: 30, alignment: .leading)
                    .padding(.leading, 10)
                    .background(Color("MintCream"))
                    .foregroundColor(Color("OxfordBlue"))
                    .padding(.bottom, 5)
                
                HStack (spacing: 0) {
                    Button {
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                            .onTapGesture(count: 2) {
                                if trashOrAdd == "trash" {
                                    if isPersonalList {
                                        fbInterface.decrementQuantity(ingredient: ingredient, amt: 1)
                                    } else {
                                        fbInterface.decrementQuantityPantry(ingredient: ingredient, amt: 1)
                                    }
                                } else {
                                    tmpAmt -= 0.1
                                }
                            }
                            .onLongPressGesture {
                                if trashOrAdd == "trash" {
                                    if isPersonalList {
                                        fbInterface.decrementQuantity(ingredient: ingredient, amt: 2)
                                    } else {
                                        fbInterface.decrementQuantityPantry(ingredient: ingredient, amt: 2)
                                    }
                                } else {
                                    tmpAmt -= 1.0
                                }
                            }
                            .onTapGesture(count: 1) {
                                let toast = Toast.text("Quantity decremented", subtitle: "Double tap for 0.1, Long Press for 1")
                                toast.show()
                                if trashOrAdd == "trash" {
                                    if isPersonalList {
                                        fbInterface.decrementQuantity(ingredient: ingredient, amt: 0)
                                    } else {
                                        fbInterface.decrementQuantityPantry(ingredient: ingredient, amt: 0)
                                    }
                                } else {
                                    tmpAmt -= 0.01
                                }
                            }
                    }
                    
                    if trashOrAdd == "trash" {
                        let amtText: String = String(format: "%.2f", ingredient.quantity)
                        Text(amtText)
                            .frame(width: 50, height: 20)
                            .background(Color("MintCream"))
                            .foregroundColor(Color("OxfordBlue"))
                    } else {
                        let amtText: String = String(format: "%.2f", tmpAmt)
                        Text(amtText)
                            .frame(width: 50, height: 20)
                            .background(Color("MintCream"))
                            .foregroundColor(Color("OxfordBlue"))
                    }
                    
                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                            .onTapGesture(count: 2) {
                                if trashOrAdd == "trash" {
                                    if isPersonalList {
                                        fbInterface.incrementQuantity(ingredient: ingredient, amt: 1)
                                    } else {
                                        fbInterface.incrementQuantityPantry(ingredient: ingredient, amt: 1)
                                    }
                                } else {
                                    tmpAmt += 0.1
                                }
                            }
                            .onLongPressGesture {
                                if trashOrAdd == "trash" {
                                    if isPersonalList {
                                        fbInterface.incrementQuantity(ingredient: ingredient, amt: 2)
                                    } else {
                                        fbInterface.incrementQuantityPantry(ingredient: ingredient, amt: 2)
                                    }
                                } else {
                                    tmpAmt += 1.0
                                }
                            }
                            .onTapGesture(count: 1) {
                                let toast = Toast.text("Quantity incremented", subtitle: "Double tap for 0.1, Long Press for 1")
                                toast.show()
                                if trashOrAdd == "trash" {
                                    if isPersonalList {
                                        fbInterface.incrementQuantity(ingredient: ingredient, amt: 0)
                                    } else {
                                        fbInterface.incrementQuantityPantry(ingredient: ingredient, amt: 0)
                                    }
                                } else {
                                    tmpAmt += 0.01
                                }
                            }
                    }
                    
                    
                    Picker(selection: $selectedUnit, label: Text(CustomUnit.allCases[selectedUnit].str), content: {
                        ForEach(0 ..< CustomUnit.allCases.count) { index in
                            Text(CustomUnit.allCases[index].str)
                                .frame(width: 80, height: 25)
                                .foregroundColor(Color("OxfordBlue"))
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80, height: 25, alignment: .center)
                    .background(Color("MintCream"))
                    .accentColor(Color("OxfordBlue"))
                    .padding(.leading)
                    .onChange(of: selectedUnit) { newValue in
                        if trashOrAdd == "trash" {
                            changeUnit(newUnit: CustomUnit.allCases[selectedUnit])
                        } else {
                            tmpSelectedUnit = selectedUnit
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        if (trashOrAdd == "trash") {
                            if isPersonalList {
                                let toast = Toast.text("Ingredient Deleted")
                                toast.show()
                                fbInterface.deleteIngredientFromPersonalList(ingredient: ingredient)
                            } else {
                                let toast = Toast.text("Ingredient Deleted")
                                toast.show()
                                fbInterface.deleteIngredientFromPantryList(ingredient: ingredient)
                            }
                        } else {
                            if isPersonalList {
                                let toast = Toast.text("Ingredient Added")
                                toast.show()
                                fbInterface.addIngredientToPersonalList(ingredient: Ingredient(id: ingredient.id, text: ingredient.text, quantity: tmpAmt, measure: CustomUnit.allCases[tmpSelectedUnit].str, food: ingredient.food, weight: ingredient.weight, foodCategory: ingredient.foodCategory, imgUrl: ingredient.imgUrl))
                            } else {
                                let toast = Toast.text("Ingredient Added")
                                toast.show()
                                fbInterface.addIngredientToPantryList(ingredient: Ingredient(id: ingredient.id, text: ingredient.text, quantity: tmpAmt, measure: CustomUnit.allCases[tmpSelectedUnit].str, food: ingredient.food, weight: ingredient.weight, foodCategory: ingredient.foodCategory, imgUrl: ingredient.imgUrl))
                            }
                        }
                    } label: {
                        Image(systemName: trashOrAdd)
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
        .frame(width: 340, height: 90)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(8)
    }
    
    func changeUnit(newUnit: CustomUnit) {
        if isPersonalList {
            fbInterface.changeIngredientUnit(ingredient: ingredient, newUnit: newUnit)
        } else {
            fbInterface.changeIngredientUnitPantry(ingredient: ingredient, newUnit: newUnit)
        }
    }
}

struct IngredientEditCardView_Previews: PreviewProvider {
    static var ingredient = Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg")
    static var previews: some View {
        IngredientEditCardView(ingredient: ingredient, withURL: ingredient.imgUrl!, trashOrAdd: "trash", isPersonalList: true)
            .previewLayout(.fixed(width: 340, height: 90))
    }
}

