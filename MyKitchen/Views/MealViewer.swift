//
//  MealViewer.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//
import SwiftUI

struct MealViewer: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    init() {
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View  {
        NavigationView {
            
            ZStack{
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading) {
                    //Header
                    Text("Meal Viewer")
                        .font(.system(size: 32, weight: .bold, design: .default))
                    
                    //Days of the week
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            MealViewerLayoutView(recipesOfWeek: fbInterface.getRecipesOfWeek())
                        }
                        Spacer()
                    }.navigationBarHidden(true)
                }
                .foregroundColor(Color("MintCream"))
            }
        }
    }
}

struct MealViewerLayoutView: View {
    let recipesOfWeek: [DaysOfWeek:[Recipe]]
    
    var body: some View {
        
        ForEach(0 ..< DaysOfWeek.allCases.count) { index in
            VStack {
                let tmpDow = DaysOfWeek.allCases[index]
                Text(tmpDow.str)
                    .foregroundColor(Color("MintCream"))
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .padding(5)
                
                ScrollView(.horizontal, showsIndicators: true){
                    HStack(spacing: 5) {
                        ForEach(recipesOfWeek[tmpDow]!, id: \.id) { recipe in
                            
                            NavigationLink(
                                destination: RecipeDetailsView(recipe: recipe),
                                label: {
                                    MealViewerCardView(recipe: recipe, withURL: recipe.imgUrl, selectedDay: tmpDow)
                                        .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("OxfordBlue"), lineWidth: 2)
                                        )
                                        .padding(.trailing)
                                        .padding(.bottom)
                                })
                        }
                    }
                }
                .padding(.leading, 10)
            }
            .frame(width: 350)
            .background(Color("AirBlue"))
            .cornerRadius(15)
        }
    }
}

struct MealViewer_Previews: PreviewProvider {
//    static var recipes = Recipe.data
    static var previews: some View {
        MealViewer()
            .background(Color("OxfordBlue"))
    }
}
