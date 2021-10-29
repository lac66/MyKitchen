//
//  GroupsHomeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsHomeView: View {
    let groceries: [Ingredient]
    var body: some View {
        
//        let groupByCategory = Dictionary(grouping: Ingredient.data) { $0.type }
    
        
        
//        List(groupByCategory, children: \.item) { row in
//            Text("Hello")
//        }
        List(groceries, children: \.items) { row in
            Text(row.type)
        }
    }
}

struct GroupsHomeView_Previews: PreviewProvider {
    let groceries: [Ingredient]
    static var previews: some View {
        GroupsHomeView(groceries: Ingredient.data)
    }
}
