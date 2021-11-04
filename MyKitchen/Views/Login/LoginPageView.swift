//
//  LoginView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import SwiftUI

struct LoginPageView: View {
    
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
                    NavigationLink(
                        destination: SignInView(),
                        label: {
                            Text("Sign In")
                                .foregroundColor(Color("MintCream"))
                        }
                    )
                    .frame(width: 300, height: 60)
                    .background(Color("Camel"))
                    .cornerRadius(15)
                    
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Create Your Account")
                                .foregroundColor(Color("MintCream"))
                        }
                    )
                    .frame(width: 300, height: 60)
                    .background(Color("Camel"))
                    .cornerRadius(15)
                    .padding()
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
