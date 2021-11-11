//
//  PersonalListView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import SwiftUI

struct PersonalListView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @State var searchText = ""
    
    init() {
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "MintCream") as Any]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack (alignment: .leading) {
                        Text("Personal List")
                            .font(.system(size: 32, weight: .bold, design: .default))
                        
                        Searchbar(placeholder: Text("Search here"), isForRecipes: false, text: $searchText)
                            .foregroundColor(Color("MintCream"))
                    }
                    .foregroundColor(Color("MintCream"))
                    .padding(.bottom)
                    
                    ScrollView {
                        VStack (spacing: 10) {
//                            ForEach(ingredients, id: \.id) { ingredient in
//                                IngredientEditCardView(ingredient: ingredient)
//                            }
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .padding(.bottom, 10)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct PersonalListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalListView()
    }
}

