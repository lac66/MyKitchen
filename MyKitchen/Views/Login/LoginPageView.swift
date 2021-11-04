//
//  LoginView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import SwiftUI

struct LoginView: View {
    
    init() {
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "MintCream") as Any]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .frame(width: 300, height: 60)
                            .background(Color("Camel"))
                            .foregroundColor(Color("MintCream"))
                            .cornerRadius(15)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Create Your Account")
                            .frame(width: 300, height: 60)
                            .background(Color("Camel"))
                            .foregroundColor(Color("MintCream"))
                            .cornerRadius(15)
                            .padding()
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
