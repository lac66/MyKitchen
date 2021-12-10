//
//  SmallMemberCards.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

// member card for group home page
struct SmallMemberCards: View {
    let user: UserGroup
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("OxfordBlue"))
            }
            let fname = user.name.split(separator: " ")[0]
            Text(fname)
                .frame(width: 60, height: 20)
                .foregroundColor(Color("OxfordBlue"))
        }
    }
}
            

struct SmallMemberCards_Previews: PreviewProvider {
    static var user = UserGroup(id: "", email: "", name: "", groupID: "")
    static var previews: some View {
        SmallMemberCards(user: user)
    }
}
