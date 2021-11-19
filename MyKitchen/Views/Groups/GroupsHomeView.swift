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
//        Color("OxfordBlue")
//            .ignoresSafeArea()
//        let groupByCategory = Dictionary(grouping: Ingredient.data) { $0.type }
    
        
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
                Text("Group homepage")
                    
                }
//                    Button("leave") {
//                        fbInterface.getMembers(id: fbInterface.currentUser?.groupID)
//                        fbInterface.getGroup()
//                    }
                
//                .foregroundColor(Color("MintCream"))
                    
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
//                        HStack {
//                            ForEach(users, id: \.self){ user in
//                                SmallMemberCards(user: user)
//                                    .frame(width: 60, height: 80)
//                            }
//                            .frame(width: 100, height: 10, alignment: .center)
//                        }
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
//                ZStack{
//                    HStack{
//                        Rectangle()
//                        Text("Edit group")
//
//                            .frame(width: 130, height: 22)
//                            .foregroundColor(Color("AirBlue"))
//                            .cornerRadius(10)
//                        Rectangle()
//                            .frame(width: 80, height: 0)
//                            .hidden()
//                        Rectangle()
//                            .frame(width: 130, height: 22)
//                            .foregroundColor(Color("AirBlue"))
//                            .cornerRadius(10)
//                            }
//                        }
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
