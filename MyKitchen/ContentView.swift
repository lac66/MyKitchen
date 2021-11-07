//
//  ContentView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI
import FirebaseAuth

let navAppearance = UINavigationBarAppearance()

struct ContentView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    
    var body: some View {
        ZStack {
            if !fbInterface.signedIn {
                LoginPageView()
            } else {
                NavBar()
            }
        }
        .onAppear {
//            fbInterface.signOut()
            fbInterface.signedIn = fbInterface.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
