//
//  GroupsHomeView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsHomeView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    
//    let groceries: [Ingredient]
//    let usersTest: [UserModel]
    
    var body: some View {
//        List(groupByCategory, children: \.item) { row in
//            Text("Hello")
//         }
        NavigationView{
            if(self.fbInterface.currentUser!.groupID == "" ){
                GroupsInitial()
            }
            else{
                ZStack{
//            Text(fbInterface.currentUser?.groupID ?? "None found")
                    Color("OxfordBlue")
                        .ignoresSafeArea()
            
                    VStack{
                        HStack {
                            VStack{
                                Text("Group homepage")
                                Text("Current user group ID: ")
                                Text(self.fbInterface.currentUser!.groupID!)
                            }
                        }
                        .foregroundColor(Color("MintCream"))
                        
                    
//                    List(groceries, children: \.items) { row in
//                        Text(row.name)
//                    }
                        HStack{
                            ZStack{
                                Rectangle()
                                    .frame(width: 350, height: 110)
                                    .foregroundColor(Color("AirBlue"))
                                    .cornerRadius(15)
                        
                                Rectangle()
                                    .frame(width: 330, height: 90)
                                    .foregroundColor(Color("MintCream"))
                                    .cornerRadius(15)
                            }
                            
                        }
                        .background(Color("OxfordBlue"))
                        HStack{
                            NavigationLink(destination: GroupsInitial().onAppear{
                                self.fbInterface.leaveGroup()
                            }.navigationBarBackButtonHidden(true)){
                                Text("leave group")
                            }
                            .foregroundColor(Color("MintCream"))
                            NavigationLink(destination: GroupsHomeView()){
                                Text("Edit group")
                            }
                        }
                    }
                    
                }
            }
        }
        .navigationBarHidden(true)
    }
    
}


//struct GroupsHomeView_Previews: PreviewProvider {
//    let groceries: [Ingredient]
//    let usersTest: [UserModel]
//    static var previews: some View {
//        GroupsHomeView(groupList:usersTest)
//    }
//}
