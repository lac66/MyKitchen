//
//  MyKitchenApp.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 10/14/21.
//

import SwiftUI
import Firebase

@main
struct MyKitchenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let eInterface = EdamamInterface()
            let fbInterface = FirebaseInterface()
            ContentView()
                .environmentObject(eInterface)
                .environmentObject(fbInterface)
        }
    }
}

// app delegate to configure firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
