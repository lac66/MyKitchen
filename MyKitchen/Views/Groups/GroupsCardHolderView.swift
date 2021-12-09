//
//  GroupsView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsCardHolderView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    
    var body: some View {
        ZStack{
            Color("OxfordBlue")
                .ignoresSafeArea()
            
            VStack{
                VStack{
                    Text("Current user group ID: ")
                    Text(self.fbInterface.currentUser!.groupID)
                    Button {
                        UIPasteboard.general.string = fbInterface.currentGroup!.groupID
                    } label: {
                        HStack {
                            Text("Copy GroupID")
                                .foregroundColor(Color("MintCream"))
                            
                            
                            Image(systemName: "doc.on.clipboard")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(2)
                                .background(Color("Camel"))
                                .foregroundColor(Color("MintCream"))
                                .cornerRadius(4)
                        }
                    }
                }
                .frame(width: 350)
                .background(Color("AirBlue"))
                .foregroundColor(Color("MintCream"))
                .cornerRadius(10)
                
                VStack(spacing: 10) {
                    ForEach(fbInterface.currentGroup!.members, id: \.id) { member in
                        if (fbInterface.currentUser!.id == fbInterface.currentGroup!.leaderID) && (fbInterface.currentUser!.id != member.id) {
                            MemberCards(user: member, isLeaderView: true)
                        } else {
                            MemberCards(user: member, isLeaderView: false)
                        }
                    }
                }

                Spacer()
                
                Button {
                    fbInterface.leaveGroup()
                } label: {
                    ZStack {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        Text("Leave Group")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                    }
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color("MintCream"))
                    .background(Color("Camel"))
                    .cornerRadius(30)
                }
                .padding(.bottom)
//                .frame(width: 350, height: 50)
//                .background(Color("AirBlue"))
//                .foregroundColor(Color("MintCream"))
//                .cornerRadius(10)
//                .font(.system(size: 20, weight: .bold, design: .default))
//                .padding()
                
//                HStack{
//                    Button("Add / Remove"){
//                    }
//                    .frame(width: 160, height: 40)
//                    .background(Color("AirBlue"))
//                    .foregroundColor(Color("MintCream"))
//                    .cornerRadius(10)
//                    .font(.system(size: 20, weight: .bold, design: .default))
//                    .padding()
//                    
//                    Button {
//                        fbInterface.leaveGroup()
//                    } label: {
//                        Text("leave group")
//                    }
//                    .frame(width: 350, height: 50)
//                    .background(Color("AirBlue"))
//                    .foregroundColor(Color("MintCream"))
//                    .cornerRadius(10)
//                    .font(.system(size: 20, weight: .bold, design: .default))
//                    .padding()
//                }
            }
            .navigationBarTitle(Text("Edit Group"), displayMode: .inline)
        }
//        NavigationView {
//            ZStack{
//                Color("OxfordBlue")
//                    .ignoresSafeArea()
//                VStack{
////                    Text("Group Edit")
////                        .frame(width: 350, height: 50, alignment: .leading)
////                        .foregroundColor(Color("MintCream"))
////                        .font(.system(size: 32, weight: .bold, design: .default))
////                        .onTapGesture {
////                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
////                        }
//
//                    VStack{
//                        Text("Current user group ID: ")
//                        Text(self.fbInterface.currentUser!.groupID)
//                        Button {
//                            UIPasteboard.general.string = fbInterface.currentGroup!.groupID
//                        } label: {
//                            HStack {
//                                Text("Copy GroupID")
//                                    .foregroundColor(Color("MintCream"))
//
//
//                                Image(systemName: "doc.on.clipboard")
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                                    .padding(2)
//                                    .background(Color("Camel"))
//                                    .foregroundColor(Color("MintCream"))
//                                    .cornerRadius(4)
//                            }
//                        }
//                    }
//                    .frame(width: 350)
//                    .background(Color("AirBlue"))
//                    .foregroundColor(Color("MintCream"))
//                    .cornerRadius(10)
//
//                    VStack(spacing: 10) {
//                        ForEach(fbInterface.currentGroup!.members, id: \.id) { member in
//                            MemberCards(user: member)
//                        }
//                    }
//
//                    Color("OxfordBlue")
//                        .ignoresSafeArea()
//                    HStack{
//                        Button("Add / Remove"){
//                        }
//                        .frame(width: 160, height: 40)
//                        .background(Color("AirBlue"))
//                        .foregroundColor(Color("MintCream"))
//                        .cornerRadius(10)
//                        .font(.system(size: 20, weight: .bold, design: .default))
//                        .padding()
//
//                        Button {
//                            self.fbInterface.leaveGroup()
//
//                        } label: {
//                            Text("leave group")
//                        }
//                        .frame(width: 350, height: 50)
//                        .foregroundColor(Color("MintCream"))
//                        .frame(width: 160, height: 40)
//                        .background(Color("AirBlue"))
//                        .foregroundColor(Color("MintCream"))
//                        .cornerRadius(10)
//                        .font(.system(size: 20, weight: .bold, design: .default))
//                        .padding()
//
////                        NavigationLink(destination: GroupsInitialView().onAppear{
////                        }.navigationBarBackButtonHidden(true)){
////                            Text("leave group")
////                        }
////                        .frame(width: 350, height: 50)
////                        .foregroundColor(Color("MintCream"))
////                        .frame(width: 160, height: 40)
////                        .background(Color("AirBlue"))
////                        .foregroundColor(Color("MintCream"))
////                        .cornerRadius(10)
////                        .font(.system(size: 20, weight: .bold, design: .default))
////                        .padding()
//                    }
//                }
//                .navigationBarHidden(true)
//            }
//            .navigationBarTitle(Text("Edit Group"), displayMode: .inline)
//        }
    }
}


struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsCardHolderView()
    }
}
