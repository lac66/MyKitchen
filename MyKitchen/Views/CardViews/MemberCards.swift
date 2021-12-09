//
//  MemberCards.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct MemberCards: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    let user: UserGroup
    let isLeaderView: Bool
    
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
                Text(user.name)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.bottom, 1)
//                Text("info")
//                    .font(.system(size: 16, weight: .regular, design: .default))
//                Text("info")
//                    .font(.system(size: 16, weight: .regular, design: .default))
            }
            .padding(.leading, 15)
            
            Spacer()
            
            if isLeaderView {
                VStack {
                    Spacer()
                    
                    Button {
                        fbInterface.removeMemberFromGroup(memID: user.id)
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .trailing)
                            .padding(2)
                            .background(Color("Camel"))
                            .foregroundColor(Color("MintCream"))
                            .cornerRadius(4)
                    }
                }
                .padding(10)
            }
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
//            .padding(.trailing, 10)
//            .padding(.bottom, 8)
        }
        .frame(width: 350, height: 90)
        .background(Color("AirBlue"))
        .foregroundColor(Color("MintCream"))
        .cornerRadius(8)
    }
}


struct MemberCards_Previews: PreviewProvider {
    static var user = UserGroup(id: "", email: "", name: "", groupID: "")
    static var previews: some View {
        MemberCards(user: user, isLeaderView: true)
    }
}
