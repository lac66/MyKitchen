//
//  MealViewer.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//
import SwiftUI

struct MealViewer: View {
    
    var recipes: [Recipe]
    var recipesForDay: [String: [Recipe]]
        
    init(recipeList: [Recipe]) {
        //recipes = make call from getRecipesFromPlanner()
        recipes = recipeList
        recipesForDay = ["Unspecified": recipes,
                         "Sunday": [],
                         "Monday": [],
                         "Tuesday": [],
                         "Wednesday": [],
                         "Thursday": [],
                         "Friday": [],
                         "Saturday": []]
        //update recipesForDay with saved recipes for week if exists
        coloredNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    var body: some View  {
        NavigationView {
            
            ZStack{
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                VStack {
                    //Header
                    Text("Meal Viewer")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("MintCream"))
                        .multilineTextAlignment(.center)
                    
                    //Days of the week
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(DaysOfWeek.allCases, id: \.self){ day in
                                //Horizontal Scrollbar with meals
                                //Unassigned
                                if day.rawValue == DaysOfWeek.Unassigned.rawValue {
                                    ScrollView(.horizontal, showsIndicators: true){
                                        HStack{
                                            ForEach(recipesForDay["Unspecified"]!, id: \.id) { recipe in
                                                MealViewerCardView(recipe: recipe)
                                                
                                            }
                                        }
                                        
                                    }
                                } else {
                                    //Days Sunday - Saturday
                                    HStack{
                                        Text(day.rawValue)
                                        .font(.largeTitle)
                                        .underline()
                                        .foregroundColor(Color("MintCream"))
                                        .padding(.leading, 10.0)
                                    Spacer()
                                    }
                                    if recipesForDay[day.rawValue] != nil{
                                        VStack{
                                            ForEach(recipesForDay[day.rawValue]!) { recipe in
                                                MealViewerCardView(recipe: recipe)
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }.navigationBarHidden(true)
                }
            }
        }
    }
}

struct MealViewer_Previews: PreviewProvider {
    static var recipes = Recipe.data
    static var previews: some View {
        MealViewer(recipeList: recipes)
            .background(Color("OxfordBlue"))
    }
}
