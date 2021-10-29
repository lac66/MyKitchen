//
//  SmallMemberCards.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct SmallMemberCards: View {
    let users: UserModel
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 53, height: 57)
                        .foregroundColor(Color("Marigold"))
                        .cornerRadius(10)
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 43, height: 49)
                        .foregroundColor(Color("OxfordBlue"))
                }
                .padding(-11)
                    
            }
            Text(users.name)
                .frame(width: 70, height: 25)
        }
    }
}
            

struct SmallMemberCards_Previews: PreviewProvider {
    static var user = UserModel.data[0]
    static var previews: some View {
        SmallMemberCards(users: user)
    }
}
