//
//  SmallMemberCards.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct SmallMemberCards: View {
    let user: UserModel
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color("Marigold"))
                        .cornerRadius(10)
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("OxfordBlue"))
                }
                    
            }
            let fname = user.name.split(separator: " ")[0]
            Text(fname)
                .frame(width: 70, height: 20)
        }
    }
}
            

struct SmallMemberCards_Previews: PreviewProvider {
    static var user = UserModel.data[0]
    static var previews: some View {
        SmallMemberCards(user: user)
    }
}
