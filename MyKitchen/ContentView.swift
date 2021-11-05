//
//  ContentView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    
    var body: some View {
        NavigationView {
            if fbInterface.signedIn {
                NavBar()
                    .navigationBarHidden(true)
            } else {
                LoginPageView()
            }
        }
        .onAppear {
            fbInterface.signedIn = fbInterface.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
