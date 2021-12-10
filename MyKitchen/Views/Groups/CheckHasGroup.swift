//
//  CheckHasGroup.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 12/7/21.
//

import SwiftUI

// view to check if user is in a group
struct CheckHasGroup: View {
    @EnvironmentObject var fbInterface: FirebaseInterface
    
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
