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
            Color("OxfordBlue")
                .ignoresSafeArea()
            
            VStack{
                Text("Group homepage")
                    .foregroundColor(Color("MintCream"))
                
                VStack{
                    List(groceries, children: \.items) { row in
                        Text(row.name)
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: 350, height: 110)
                            .foregroundColor(Color("AirBlue"))
                            .cornerRadius(15)
                        
                        Rectangle()
                            .frame(width: 330, height: 90)
                            .foregroundColor(Color("MintCream"))
                            .cornerRadius(15)
                        
                        HStack {
                            ForEach(users, id: \.self){ user in
                                SmallMemberCards(user: user)
                                    .frame(width: 60, height: 80)
                            }
                            .frame(width: 100, height: 10, alignment: .center)
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
