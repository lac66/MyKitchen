//
//  GroupsInitial.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 11/12/21.
//

import SwiftUI

struct GroupsInitialView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @State private var showingGroupHome = false
    init() {
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                VStack{
                    ZStack{
                        Rectangle()
                            .frame(width: 370, height: 275)
                            .foregroundColor(Color("AirBlue"))
                            .cornerRadius(15)
                        
                        Rectangle()
                            .frame(width: 350, height: 250)
                            .foregroundColor(Color("MintCream"))
                            .cornerRadius(15)
                        Text("Groups are a way to connect with different people to share grocery lists, assist in letting group members know when to go to the store, and even assit in getting the prices for the group list!")
                            .foregroundColor(Color("OxfordBlue"))
                            .frame(width: 275, height: 325)
                    }
                    
                    HStack{
                        Button {
                            fbInterface.createGroup()
                        } label: {
                            Text("Create group")
                                .foregroundColor(Color("MintCream"))
                        }
                        
                        NavigationLink(destination: JoinGroupView()){
                            Text("Join group")
                        }
                        .foregroundColor(Color("MintCream"))
                        
                    }
                    
                }
                .navigationBarHidden(true)
            }
            
        }
    }
    
}

struct GroupsInitial_Previews: PreviewProvider {
    static var previews: some View {
        GroupsInitialView()
    }
}
