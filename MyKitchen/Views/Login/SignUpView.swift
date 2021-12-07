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
    @State var passwordConfirmInput : String = ""
    
    @State var hasError: Bool = false
    @State var localErrMsg: String = ""
    
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
                        .alert(isPresented: $hasError) {
                            Alert(title: Text("Sign Up Error"), message: Text(localErrMsg), dismissButton: .default(Text("Ok")))
                        }
                    
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
                    
                    SecureField("", text: $passwordConfirmInput)
                        .placeholder(when: passwordConfirmInput.isEmpty, placeholder: {
                            Text("Confirm Password")
                                .foregroundColor(Color("MintCream"))
                        })
                        .frame(width: 300, height: 60)
                        .padding(.leading)
                        .border(Color("MintCream"), width: 2)
                        .cornerRadius(10)
                        .foregroundColor(Color("MintCream"))
                    
                    Button {
                        if nameInput.isEmpty || nameInput == " " {
                            print("Empty name")
                            localErrMsg = "Name input cannot be empty"
                            hasError = true
                        } else if emailInput.isEmpty {
                            print("Empty email")
                            localErrMsg = "Email input cannot be empty"
                            hasError = true
                        } else if passwordInput.isEmpty {
                            print("Empty password")
                            localErrMsg = "Password input cannot be empty"
                            hasError = true
                        } else if passwordConfirmInput.isEmpty {
                            print("Empty confirmation")
                            localErrMsg = "Password must be confirmed"
                            hasError = true
                        } else if passwordInput != passwordConfirmInput {
                            print("Pwd and conf dont match")
                            localErrMsg = "Password and Confirmation do not match"
                            hasError = true
                        } else {
                            fbInterface.signUp(name: nameInput, email: emailInput, password: passwordInput)
                        }
                    } label: {
                        Text("Create Your Account")
                            .foregroundColor(Color("MintCream"))
                    }
                    .alert(isPresented: $fbInterface.authError) {
                        Alert(title: Text("Sign Up Error"), message: Text(fbInterface.errorMsg), dismissButton: .default(Text("Ok")))
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
                    
//                    NavigationLink(
//                        destination: SignInView(),
//                        label: {
//                            Text("Already have an account? Sign in")
//                                .foregroundColor(Color("MintCream"))
//                        }
//                    )
//                    .frame(width: 300, height: 60)
//                    .cornerRadius(15)
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
