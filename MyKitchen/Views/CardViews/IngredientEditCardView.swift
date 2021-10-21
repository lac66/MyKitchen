//
//  IngredientEditCardView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/21/21.
//

import SwiftUI

struct IngredientEditCardView: View {
    let ingredient: Ingredient
    var body: some View {
        HStack() {
            //Image
            VStack() {
                Text(ingredient.name)
                HStack () {
                    Button {
                        print("tapped minus")
                    } label: {
                        Text("-")
                            .frame(width: 15, height: 15)
                            .background(Color(red: 0.6862745098039216, green: 0.5686274509803921, blue: 0.39215686274509803))
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(2)
                    }
//                    TextField("Placeholder", text: "1")
                    
                    // button and qty
                    // measurement
                    // button
                }
            }
        }
        .frame(width: 400, height: 80)
        .background(Color(red: 0.47058823529411764, green: 0.6313725490196078, blue: 0.7333333333333333))
        
//        VStack() {
//            Text(recipe.name)
//                .font(.system(size: 24, weight: .bold, design: .default))
//                .padding(.bottom, 1)
//            Text(recipe.cookTime)
//                .font(.system(size: 16, weight: .regular, design: .default))
//            Text(recipe.difficulty)
//                .font(.system(size: 16, weight: .regular, design: .default))
//            //                .padding(-10)
//        }
//        .frame(width: 400, height: 80)
//        .background(Color(red: 0.47058823529411764, green: 0.6313725490196078, blue: 0.7333333333333333))
    }
}

struct IngredientEditCardView_Previews: PreviewProvider {
    static var ingredient = Ingredient.data[0]
    static var previews: some View {
        IngredientEditCardView(ingredient: ingredient)
            .background(Color.red)
            .previewLayout(.fixed(width: 400, height: 80))
    }
}

