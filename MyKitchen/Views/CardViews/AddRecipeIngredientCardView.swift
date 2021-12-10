//
//  AddRecipeIngredientCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 12/9/21.
//

import SwiftUI
import ToastViewSwift

// edit ingredient card for uploading recipes
struct AddRecipeIngredientCardView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    @EnvironmentObject var eInterface: EdamamInterface
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    @State var selectedUnit : Int
    @State var amtTextInput : String = "0"
    @State var tmpSelectedUnit: Int
    
    @State var errCheck : Bool = false
    @State var errMsg : String = ""
    
    let ingredient: Ingredient
    
    init(ingredient : Ingredient, withURL url: String?) {
        self.ingredient = ingredient
        self.tmpSelectedUnit = CustomUnit.allCases.firstIndex(of: ingredient.unit!)!
        self._selectedUnit = State(initialValue: CustomUnit.allCases.firstIndex(of: ingredient.unit!)!)
        if (url == nil) {
            imageLoader = ImageLoader(urlString: "")
        } else {
            imageLoader = ImageLoader(urlString: url!)
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                // card image
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
                // ingredient name
                Text(ingredient.food)
                    .frame(width: 210, height: 30, alignment: .leading)
                    .padding(.leading, 10)
                    .background(Color("MintCream"))
                    .foregroundColor(Color("OxfordBlue"))
                    .padding(.bottom, 5)
                
                HStack (spacing: 0) {
                    // quantity section
                    Button {
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                        // different tap guestures for different amounts
                            .onTapGesture(count: 2) {
                                var tmpAmt = Double(amtTextInput)
                                if tmpAmt != nil {
                                    tmpAmt! -= 0.1
                                    amtTextInput = String(format: "%.2f", tmpAmt!)
                                }
                            }
                            .onLongPressGesture {
                                var tmpAmt = Double(amtTextInput)
                                if tmpAmt != nil {
                                    tmpAmt! -= 1.0
                                    amtTextInput = String(format: "%.2f", tmpAmt!)
                                }
                            }
                            .onTapGesture(count: 1) {
                                let toast = Toast.text("Quantity decremented", subtitle: "Double tap for 0.1, Long Press for 1")
                                toast.show()
                                var tmpAmt = Double(amtTextInput)
                                if tmpAmt != nil {
                                    tmpAmt! -= 0.01
                                    amtTextInput = String(format: "%.2f", tmpAmt!)
                                }
                            }
                    }
                    
                    // enter quantity
                    TextField("", text: $amtTextInput)
                        .placeholder(when: amtTextInput.isEmpty, placeholder: {
                            Text("#")
                                .frame(width: 50, height: 20)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("OxfordBluePlaceholder"))
                        })
                    // validates text after entry
                        .onChange(of: amtTextInput) { newValue in
                            let amt = Double(amtTextInput)
                            if amtTextInput.isEmpty {
                                return
                            }
                            
                            if amt == nil {
                                errMsg = "Quantity is not a number"
                                errCheck = true
                            } else if amt! < 0 {
                                errMsg = "Quantity must be a positive value"
                                errCheck = true
                            }
                        }
                        .padding(.leading, 2)
                        .frame(width: 50, height: 20)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("OxfordBlue"))
                        .background(Color("MintCream"))
                    
                    // add button, same as minus
                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                            .onTapGesture(count: 2) {
                                var tmpAmt = Double(amtTextInput)
                                if tmpAmt != nil {
                                    tmpAmt! += 0.1
                                    amtTextInput = String(format: "%.2f", tmpAmt!)
                                }
                            }
                            .onLongPressGesture {
                                var tmpAmt = Double(amtTextInput)
                                if tmpAmt != nil {
                                    tmpAmt! += 1.0
                                    amtTextInput = String(format: "%.2f", tmpAmt!)
                                }
                            }
                            .onTapGesture(count: 1) {
                                let toast = Toast.text("Quantity incremented", subtitle: "Double tap for 0.1, Long Press for 1")
                                toast.show()
                                var tmpAmt = Double(amtTextInput)
                                if tmpAmt != nil {
                                    tmpAmt! += 0.01
                                    amtTextInput = String(format: "%.2f", tmpAmt!)
                                }
                            }
                    }
                    
                    // picker to choose units
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
                            tmpSelectedUnit = selectedUnit
                        }
                    
                    Spacer()
                    
                    // button to validate entry and add ingredient to recipe
                    Button {
                        let tmpAmt = Double(amtTextInput)
                        if amtTextInput.isEmpty {
                            return
                        }
                        
                        if tmpAmt == nil {
                            errMsg = "Quantity is not a number"
                            errCheck = true
                        } else if tmpAmt! < 0 {
                            errMsg = "Quantity must be a positive value"
                            errCheck = true
                        } else {
                            let toast = Toast.text("Ingredient Added")
                            toast.show()
                            eInterface.selectedIngredient = Ingredient(id: ingredient.id, text: ingredient.text, quantity: tmpAmt!, measure: CustomUnit.allCases[tmpSelectedUnit].str, food: ingredient.food, weight: ingredient.weight, foodCategory: ingredient.foodCategory, imgUrl: ingredient.imgUrl)
                        }
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(2)
                            .foregroundColor(Color("MintCream"))
                            .background(Color("Camel"))
                            .cornerRadius(4)
                    }
                    .alert(isPresented: $errCheck) {
                        Alert(title: Text("Quantity Error"), message: Text(errMsg), dismissButton: .default(Text("Ok")))
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
}

struct AddRecipeIngredientCardView_Previews: PreviewProvider {
    static var ingredient = Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg")
    static var previews: some View {
        AddRecipeIngredientCardView(ingredient: ingredient, withURL: ingredient.imgUrl!)
            .previewLayout(.fixed(width: 340, height: 90))
    }
}


