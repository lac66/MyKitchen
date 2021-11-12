//
//  SignInView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/4/21.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @State var emailInput : String = ""
    @State var passwordInput : String = ""
    
    init() {
        navAppearance.backgroundColor = UIColor(named: "OxfordBlue")
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "Camel") as Any]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("MyKitchenLogo")
                        .resizable()
                        .frame(width: 300, height: 120)
                        .padding(.bottom, 150)
                    
                    TextField("", text: $emailInput)
                        .placeholder(when: emailInput.isEmpty, placeholder: {
                            Text("Email")
                                .foregroundColor(Color("MintCream"))
                        })
                        .frame(width: 300, height: 60)
                        .padding(.leading)
                        .border(Color("MintCream"), width: 2)
                        .cornerRadius(10)
                        .foregroundColor(Color("MintCream"))
                    
                    SecureField("", text: $passwordInput)
                        .placeholder(when: passwordInput.isEmpty, placeholder: {
                            Text("Password")
                                .foregroundColor(Color("MintCream"))
                        })
                        .frame(width: 300, height: 60)
                        .padding(.leading)
                        .border(Color("MintCream"), width: 2)
                        .cornerRadius(10)
                        .foregroundColor(Color("MintCream"))
                    
                    Button {
                        fbInterface.signIn(email: emailInput, password: passwordInput)
                    } label: {
                        Text("Sign In")
                            .foregroundColor(Color("MintCream"))
                    }
                    .frame(width: 300, height: 60)
                    .background(Color("Camel"))
                    .cornerRadius(15)
                    .padding(.top)
                    
                    
                    // todo send somewhere else
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
