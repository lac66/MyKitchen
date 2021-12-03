//
//  JoinGroup.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/13/21.
//

import SwiftUI

struct JoinGroupView: View {
    @State var groupSearch = ""
    var body: some View {
        ZStack{
            Color("OxfordBlue").edgesIgnoringSafeArea(.all)
            VStack{
                ZStack {
                    Rectangle()
                        .frame(width: 370, height: 275)
                        .foregroundColor(Color("AirBlue"))
                        .cornerRadius(15)
                    
                    Rectangle()
                        .frame(width: 350, height: 250)
                        .foregroundColor(Color("MintCream"))
                        .cornerRadius(15)
                    Text("Joining a group is simple! All you have to do is have the creator of the group you are attempting to join send you the groupID via text, email, or have them read it out to you, where you then search and they will have to accept you!")
                        .foregroundColor(Color("OxfordBlue"))
                        .frame(width: 300, height: 300)
                }
                //                Searchbar(placeholder: Text("Enter Group ID "), isForRecipes: false, text: $groupSearch)
                //                    .frame(width: 375)
                .navigationBarHidden(true)
            }
        }
    }
}


struct JoinGroup_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupView()
    }
}
