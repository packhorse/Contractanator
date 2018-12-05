//
//  AppDelegate.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/27/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // [START default_firestore]
        FirebaseApp.configure()
        
        let db = Firestore.firestore()
        // [END default_firestore]
        
        UserController.shared.fetchLoggedInUserProfile { (success) in
            if success {
                print("Yes! Signed in already. Here is the user: \(UserController.shared.loggedInUser)")
            } else {
                print("No! couldn't find a user signed in")
            }
        }
        
        return true
    }


}

