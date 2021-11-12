//
//  SignUpView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/4/21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    @State var nameInput : String = ""
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
                        .padding(.bottom, 120)
                    
                    TextField("", text: $nameInput)
                        .placeholder(when: nameInput.isEmpty, placeholder: {
                            Text("Full Name")
                                .foregroundColor(Color("MintCream"))
                        })
                        .navigationBarTitle("Sign Up", displayMode: .inline)
                        .frame(width: 300, height: 60)
                        .padding(.leading)
                        .border(Color("MintCream"), width: 2)
                        .cornerRadius(10)
                        .foregroundColor(Color("MintCream"))
                    
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
                        fbInterface.signUp(name: nameInput, email: emailInput, password: passwordInput)
                    } label: {
                        Text("Create Your Account")
                            .foregroundColor(Color("MintCream"))
                    }
                    .frame(width: 300, height: 60)
                    .background(Color("Camel"))
                    .cornerRadius(15)
                    .padding(.top)
                    
                    Text("By creating an account, you agree to our Terms and Conditions")
                        .frame(width: 300, height: 60)
                        .foregroundColor(Color("MintCream"))
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(
                        destination: SignInView(),
                        label: {
                            Text("Already have an account? Sign in")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
