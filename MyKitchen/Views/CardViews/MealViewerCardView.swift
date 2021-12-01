//
//  MealViewerCard.swift
//  MyKitchen
//
//  Created by Erick Garcia-Lopez on 10/22/21.
//
import SwiftUI

struct MealViewerCardView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface

    let recipe: Recipe
    let tmpDay: DaysOfWeek
    @State private var showListSelection = false
    @State var selectedDay: DaysOfWeek
    
    init(recipe: Recipe, selectedDay: DaysOfWeek) {
        self.recipe = recipe
        self.selectedDay = selectedDay
        self.tmpDay = selectedDay
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.system(size: 24, design: .default))
                    .foregroundColor(Color("OxfordBlue"))
                    .padding(.bottom, 1)
                Spacer()
                /*
                 NavigationLink(
                 EditRecipeView()){
                 ZStack {
                 Rectangle()
                 .frame(width: 20, height: 20)
                 .foregroundColor(Color("Camel"))
                 .cornerRadius(4)
                 
                 Image(systemName: "pencil")
                 }
                 }
                 */
                
                ZStack {
                    Button("Select Day"){
                        if (showListSelection) {
                            //self.setFromDay()
                            // add to day now
                        }
                        showListSelection.toggle()
                        
                    }
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(4)
                    
                    Image(systemName: "plus")
                }
                
                if showListSelection {
                    VStack {
                        Picker("Choose a day to add the recipe to", selection: $selectedDay){ //}, selection: $selectedDay.onChange(changeDay)) {
                            ForEach(DaysOfWeek.allCases) { day in//, id: \.self
                                Text(day.rawValue).tag(day)
                            }
                        }.onChange(of: selectedDay, perform: { tag in
                            changeDay(tag)
                        })
                    }
                    .foregroundColor(Color("MintCream"))
                    .frame(height: 60)
                }
                
            }
            .padding(.horizontal, 10.0)
            Image("food")
                .resizable()
                .frame(width: 350, height: 140)
                .cornerRadius(6)
                .padding(.bottom, 5.0)
                .padding(.top, -10.0)
        }
        .frame(width: 400, height: 175)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(15)
    }
    
    func changeDay(_ tag: DaysOfWeek) {
        print("Entered change Day")
        fbInterface.updateUserRecipesOfWeek(initialDay: tmpDay, newDay: selectedDay, recipe: recipe)
    }
}

struct MealViewerCardView_Previews: PreviewProvider {
//    static var recipe = Recipe.data[0]
    static let recipe = Recipe(id: "id", name: "name", imgUrl: "imgUrl", sourceUrl: "sourceUrl", yield: 1, ingString: ["ingArr"], ingredients: [Ingredient(id: "id", text: "text", quantity: 1.0, measure: "measure", food: "food", weight: 1.0, foodCategory: "foodCategory", imgUrl: "https://www.edamam.com/food-img/627/627582f390a350d98c367f89c3a943fe.jpg")], calories: 1.0, cuisineType: ["cuisineType"], mealType: ["mealType"], recipeInstructions: nil)
    static var previews: some View {
        MealViewerCardView(recipe: recipe, selectedDay: .Unassigned)
            .background(Color.white)
            .previewLayout(.fixed(width: 400, height: 175))
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
            })
    }
}
 
