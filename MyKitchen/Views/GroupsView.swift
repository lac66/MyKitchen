//
//  GroupsView.swift
//  MyKitchen
//
//  Created by Noah Gillespie on 10/28/21.
//

import SwiftUI

struct GroupsView: View {
    let users: UserModel
    var body: some View {
        MemberCards(users: users)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var users = UserModel.data
    static var previews: some View {
        GroupsView(users: users[0])
    }
}
