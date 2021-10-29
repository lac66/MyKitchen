//
//  MemberCards.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct MemberCards: View {
    let users: UserModel
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(Color("Camel"))
                    .cornerRadius(10)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color("OxfordBlue"))
                    .cornerRadius(6)
                
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text(users.name)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.bottom, 1)
//                Text("info")
//                    .font(.system(size: 16, weight: .regular, design: .default))
//                Text("info")
//                    .font(.system(size: 16, weight: .regular, design: .default))
            }
            .padding(.leading, 15)
            
            Spacer()
            
//            VStack (spacing: 4) {
//                Spacer()
//
//                Button {
//
//                } label: {
//                    Image(systemName: "heart.fill")
//                        .frame(width: 20, height: 20)
//                        .background(Color("Camel"))
//                        .cornerRadius(4)
//                }
//
//                Button {
//
//                } label: {
//                    Image(systemName: "plus")
//                        .frame(width: 20, height: 20)
//                        .background(Color("Camel"))
//                        .cornerRadius(4)
//                }
//            }
            .padding(.trailing, 10)
            .padding(.bottom, 8)
        }
        .frame(width: 350, height: 90)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(8)
    }
}


struct MemberCards_Previews: PreviewProvider {
    static var user = UserModel.data[0]
    static var previews: some View {
        MemberCards(users: user)
    }
}
