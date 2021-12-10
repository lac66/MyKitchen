//
//  ShoppingCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 12/1/21.
//

import SwiftUI

// ingredient card for shopping view
struct ShoppingCardView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    @State var checkedOff: Bool
    
    let ingredient: Ingredient
    
    init(ingredient : Ingredient, withURL url: String?, checkedOff: Bool) {
        self.ingredient = ingredient
        self.checkedOff = checkedOff
        
        if (url == nil) {
            imageLoader = ImageLoader(urlString: "")
        } else {
            imageLoader = ImageLoader(urlString: url!)
        }
    }
    
    var body: some View {
        ZStack {
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
                    Text(ingredient.food.capitalized)
                        .frame(width: 210, height: 30, alignment: .leading)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .padding(.leading, 10)
                        .padding(.bottom, 5)
                    
                    let amtText: String = String(format: "%.2f", ingredient.quantity)
                    HStack {
                        Text(amtText)
                            .frame(width: 60)
                        Text(ingredient.unit!.str)
                            .frame(width: 50, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "strikethrough")
                            .frame(width: 20, height: 20)
                            .background(Color("Camel"))
                            .cornerRadius(4)
                            .padding(.trailing)
                    }
                    
                }
                .padding(.leading, 15)
            }
            .frame(width: 340, height: 90)
            .background(Color("AirBlue"))
            .foregroundColor(Color("MintCream"))
            .cornerRadius(8)
            
            // covers with gray tint if checked off
            if (checkedOff) {
                Rectangle()
                    .frame(width: 340, height: 90)
                    .foregroundColor(Color("OxfordBluePlaceholder"))
                    .cornerRadius(15)
            }
        }
    }
}

struct ShoppingCardView_Previews: PreviewProvider {
    static var ingredient = Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg")
    
    static var previews: some View {
        ShoppingCardView(ingredient: ingredient, withURL: ingredient.imgUrl, checkedOff: false)
    }
}
