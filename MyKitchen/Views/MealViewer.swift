//
//  MealViewer.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//

import SwiftUI

struct MealViewer: View {
    
    let recipes: [Recipe]
    
    init(recipeList: [Recipe]) {
        recipes = recipeList
        
        coloredNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    var body: some View  {
        // entire page should be UICollectionView where you can drag from top HStack to bottom V Stack
        VStack {
            Text("Meal Viewer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            //Horizontal Scrollbar with meals
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ForEach(recipes, id: \.id) { recipe in
                        MealViewerCardView(recipe: recipe)
                    }
                }
                
            }
            Spacer()
            //Days of the week
            HStack {
                VStack {
                    Group{
                        Spacer()
                        Text("Sunday")
                            .font(.largeTitle)
                            .underline()
                            .padding(.trailing, 250.0)

                            
                        Spacer()

                    }
                    Group{
                        HStack {
                            Text("Monday")
                                .font(.largeTitle)
                                .underline()
                                .padding(.trailing, 240.0)
                        }
                        MealViewerCardView(recipe: recipes[0])
                        Spacer()

                    }
                    Group{
                        Text("Tuesday")
                            .font(.largeTitle)
                            .underline()
                            .padding(.trailing, 250.0)


                        Spacer()

                    }
                        
                    Group{
                        Text("Wednesday")
                            .font(.largeTitle)
                            .underline()
                            .padding(.trailing, 200.0)

                        Spacer()

                    }
                    
                    Group{
                        Text("Thursday")
                            .font(.largeTitle)
                            .underline()
                            .padding(.trailing, 230.0)

                        Spacer()

                    }
                    
                    Group{
                        Text("Friday")
                            .font(.largeTitle)
                            .underline()
                            .padding(.trailing, 280.0)

                        Spacer()

                    }
                    
                    Group{
                        Text("Saturday")
                            .font(.largeTitle)
                            .underline()
                            .padding(.trailing, 240.0)

                        Spacer()

                    }
                }
                Spacer()
            }
            
            Spacer()

        }.background(Color("OxfordBlue"))
            .foregroundColor(Color("MintCream"))
            .cornerRadius(15)
        Spacer()
    }
}


struct MealViewer_Previews: PreviewProvider {
    static var recipes = Recipe.data
    static var previews: some View {
        MealViewer(recipeList: recipes)
            .background(Color("OxfordBlue"))
    }
}
