//
//  GroupsHomeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsHomeView: View {
    let groceries: [Ingredient]
    let users: [UserModel]
    var body: some View {
//        Color("OxfordBlue")
//            .ignoresSafeArea()
//        let groupByCategory = Dictionary(grouping: Ingredient.data) { $0.type }
    
        
//        List(groupByCategory, children: \.item) { row in
//            Text("Hello")
//        }
        ZStack{
        VStack{
            Text("Group homepage")
            VStack{
                List(groceries, children: \.items) { row in
                    Text(row.name)
                }
            ZStack{
                HStack{
                    Rectangle()
                        .frame(width: 363, height: 106)
                        .foregroundColor(Color("AirBlue"))
                        .cornerRadius(10)
                }
                HStack{
                    Rectangle()
                        .frame(width: 327, height: 74)
                        .foregroundColor(Color("MintCream"))
                }
                HStack{
                    ForEach(users, id: \.self){ user in
                        SmallMemberCards(users: user)
                    }
                    .frame(width: 100, height: 10, alignment: .leading)
                }
            }
            .background(Color("OxfordBlue"))
                ZStack{
                    HStack{
                        Rectangle()
                            .frame(width: 130, height: 22)
                            .foregroundColor(Color("AirBlue"))
                            .cornerRadius(10)
                        Rectangle()
                            .frame(width: 80, height: 0)
                            .hidden()
                        Rectangle()
                            .frame(width: 130, height: 22)
                            .foregroundColor(Color("AirBlue"))
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}

struct GroupsHomeView_Previews: PreviewProvider {
    let groceries: [Ingredient]
    let users: [UserModel]
    static var previews: some View {
        GroupsHomeView(groceries: Ingredient.data, users: UserModel.data)
    }
}
