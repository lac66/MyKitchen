//
//  CheckHasGroup.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 12/7/21.
//

import SwiftUI

struct CheckHasGroup: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
//    init() {
//        print("CheckHasGroup init")
//    }
    
    var body: some View {
        ZStack {
            if !fbInterface.hasGroup {
                GroupsInitialView()
                    .environmentObject(fbInterface)
            } else {
                GroupsHomeView()
                    .environmentObject(fbInterface)
            }
        }
        .navigationBarHidden(true)
    }
}

struct CheckHasGroup_Previews: PreviewProvider {
    static var previews: some View {
        CheckHasGroup()
    }
}