//
//  FirebaseInterface.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/5/21.
//

import Foundation
import FirebaseAuth

class FirebaseInterface : ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //success
            self?.signedIn = true
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //success
            self?.signedIn = true
        }
    }
}
