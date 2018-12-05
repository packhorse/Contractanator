//
//  UserController.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

class UserController {
    
    // MARK: - Properties
    
    // Singleton
    static let shared = UserController()
    private init() {}
    
    // Source of Truth
    var loggedInUser: User?
    
    // MARK: - Functions
    
    func createNewUser(withFirstName firstName: String,
                       lastName: String,
                       username: String,
                       phone: String,
                       email: String,
                       password: String,
                       completion: @escaping (Bool) -> Void) {
        
        FirebaseManager.createFirebaseUser(withEmail: email, password: password) { (userID) in
            guard let userID = userID else {
                print("Error: unable to create user \n\(#function)")
                completion(false)
                return
            }
            
            let newUser = User(firstName: firstName, lastName: lastName, username: username, phone: phone, userID: userID)
            
            FirebaseManager.createUserProfile(withUser: newUser, completion: { (success) in
                if success {
                    print("Successfully created the user profile")
                } else {
                    print("Failed to create the user profile")
                }
                self.loggedInUser = newUser
                completion(true)
            })
        }
    }
    
    func fetchLoggedInUser(completion: @escaping (Bool) -> Void) {
        
        FirebaseManager.fetchUserProfile { (user) in
            guard let user = user else {
                print("No user is signed into firebase on this device")
                completion(false)
                return
            }
            
            self.loggedInUser = user
            completion(true)
        }
    }
}
