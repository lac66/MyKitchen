//
//  JoinGroup.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/13/21.
//

import SwiftUI

// view to allow users to search and join groups
struct JoinGroupView: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
    @State var groupSearch = ""
    @State var entryError = false
    @State var errorMsg = ""
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
                            findGroup()
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: typingCheck!)
                    }
                    .frame(width: 350)
                    .foregroundColor(Color("MintCream"))
                    .alert(isPresented: $entryError) {
                        Alert(title: Text("Group Search Error"), message: Text(errorMsg), dismissButton: .default(Text("Ok")))
                    }
            }
        }
    }
    
    // function to validate and search for groups with given id
    func findGroup() {
        if (groupSearch.isEmpty) {
            return
        }
        if (groupSearch.count != 36 || !groupSearch.contains("-")) {
            errorMsg = "Invalid Group ID"
            entryError = true
            return
        }
        print("search")
        fbInterface.joinGroup(groupID: groupSearch)
    }
}


struct JoinGroup_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupView()
    }
}
