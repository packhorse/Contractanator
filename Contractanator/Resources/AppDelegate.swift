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
        
        let _ = Firestore.firestore()
        // [END default_firestore]
        
        // Fetch the logged in user
        UserController.shared.fetchLoggedInUserProfile { (_) in
            
            // Fetch all listings
            JobListingController.shared.fetchAllJobListings { (success) in
                if success {
                    JobListingController.shared.getMyListings()
                }
            }
        }
        return true
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController == tabBarController.viewControllers?[2] {
            if UserController.shared.loggedInUser == nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "signInVC") as! LogInViewController
                tabBarController.present(loginVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}
