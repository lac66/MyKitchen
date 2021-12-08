//
//  JoinGroup.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/13/21.
//

import SwiftUI

struct JoinGroupView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    @State var groupSearch = ""
    @State var typingCheck: DispatchWorkItem?
    
    var body: some View {
        ZStack{
            Color("OxfordBlue").edgesIgnoringSafeArea(.all)
            VStack{
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 275)
                        .foregroundColor(Color("AirBlue"))
                        .cornerRadius(15)
                        .navigationBarTitle("Join a Group", displayMode: .inline)
                    
                    Rectangle()
                        .frame(width: 330, height: 250)
                        .foregroundColor(Color("MintCream"))
                        .cornerRadius(15)
                    Text("Joining a group is simple! All you have to do is have the creator of the group you are attempting to join send you the groupID via text, email, or have them read it out to you, where you then search and they will have to accept you!")
                        .foregroundColor(Color("OxfordBlue"))
                        .frame(width: 300, height: 300)
                }
                
                Searchbar(placeholder: "Enter Group ID ", isForRecipes: false, text: $groupSearch)
                    .onChange(of: groupSearch) { newValue in
                        if (typingCheck != nil) {
                            typingCheck!.cancel()
                            typingCheck = nil
                        }
                        
                        typingCheck = DispatchWorkItem {
                            print("search")
                            fbInterface.joinGroup(groupID: groupSearch)
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: typingCheck!)
                    }
                    .frame(width: 350)
                    .foregroundColor(Color("MintCream"))
//                .navigationBarHidden(true)
            }
        }
    }
}


struct JoinGroup_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupView()
    }
}
