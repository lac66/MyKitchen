//
//  LoginView.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/3/21.
//

import SwiftUI

struct LoginPageView: View {
    @EnvironmentObject var fbInterface : FirebaseInterface
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("OxfordBlue").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("MyKitchenLogo")
                        .resizable()
                        .frame(width: 300, height: 120)
                        .padding(.bottom, 150)
                    
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
                .navigationBarTitle("Login", displayMode: .inline)
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
