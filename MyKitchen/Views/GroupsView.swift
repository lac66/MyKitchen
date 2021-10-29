//
//  GroupsView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsView: View {
    let users: [UserModel]
    init(groupList: [UserModel]) {
        users = groupList
        
        coloredNavAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    var body: some View {
       // MemberCards(users: users)
        VStack(spacing: 10) {
            ForEach(users, id: \.self) { user in
                MemberCards(users: user)
            }
            HStack{
                Button("Add / Remove"){
                    
                }
                    .frame(width: 160, height: 40)
                    .background(Color("AirBlue"))
                    .foregroundColor(Color("MintCream"))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding()
                Button("Leave group") {
                }
                    .frame(width: 160, height: 40)
                    .background(Color("AirBlue"))
                    .foregroundColor(Color("MintCream"))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding()
            }
        }
        .padding(.top)
    }
}


struct GroupsView_Previews: PreviewProvider {
    static var users = UserModel.data
    static var previews: some View {
        GroupsView(groupList: users)
    }
}
