//
//  SignInView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/4/21.
//

import SwiftUI

struct SignInView: View {
    @State var emailInput : String = ""
    @State var passwordInput : String = ""
    
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
                    TextField("", text: $emailInput)
                        .placeholder(when: emailInput.isEmpty, placeholder: {
                            Text("Email")
                                .foregroundColor(Color("MintCream"))
                                .padding(.leading)
                        })
                        .frame(width: 300, height: 60)
                        .border(Color("MintCream"), width: 2)
                        .cornerRadius(10)
                    
                    SecureField("", text: $passwordInput)
                        .placeholder(when: passwordInput.isEmpty, placeholder: {
                            Text("Password")
                                .foregroundColor(Color("MintCream"))
                                .padding(.leading)
                        })
                        .frame(width: 300, height: 60)
                        .border(Color("MintCream"), width: 2)
                        .cornerRadius(10)
                    
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
                    .padding(.top)
                    
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color("MintCream"))
                        }
                    )
                    .frame(width: 300, height: 60)
                    .cornerRadius(15)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
