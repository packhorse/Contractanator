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
    var loggedInUser: User? {
        didSet {
            JobListingController.shared.getMyListings()
        }
    }
    
    // MARK: - Functions
    
    func createNewUser(withFirstName firstName: String,
                       lastName: String,
                       username: String,
                       phone: String,
                       bio: String,
                       email: String,
                       password: String,
                       completion: @escaping (Bool) -> Void) {
        
        FirebaseManager.createFirebaseUser(withEmail: email, password: password) { (userID) in
            guard let userID = userID else {
                print("Error: unable to create user \n\(#function)")
                completion(false)
                return
            }
            
            let newUser = User(firstName: firstName, lastName: lastName, username: username, phone: phone, bio: bio, userID: userID)
            
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
    
    func signInUser(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        FirebaseManager.signInExistingUser(withEmail: email, password: password) { (loggedInUser) in
            guard let loggedInUser = loggedInUser else {
                print("Error, unable to log-in the user")
                completion(false)
                return
            }
            
            // Set the Logged In User on self
            self.loggedInUser = loggedInUser
            completion(true)
            return
        }
    }
    
    func isUsernameAvailable(withUsername username: String, completion: @escaping (Bool) -> Void) {
        
        // Create a reference to the users collection
        let usersRef = FirebaseManager.db.collection(Constants.usersTypeKey)
        
        // Create a query against the collection
        let query = usersRef.whereField(Constants.usernameKey, isEqualTo: username)
        
        query.getDocuments { (results, error) in
            if let error = error {
                print("Error: Could not check username status \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let userDoc = results?.documents.first, userDoc.exists else {
                print("No document exists")
                completion(true)
                return
            }
            
            completion(false)
        }
    }
    
    func fetchLoggedInUserProfile(completion: @escaping (Bool) -> Void) {
        
        FirebaseManager.fetchCurrentUserProfile { (user) in
            guard let user = user else {
                print("No user is signed into firebase on this device")
                completion(false)
                return
            }
            
            self.loggedInUser = user
            completion(true)
        }
    }
    
    func fetchUserProfile(withUsername username: String, completion: @escaping (User?) -> Void) {
        
        FirebaseManager.fetchUserProfile(withUsername: username) { (user) in
            guard let user = user else {
                print("Error trying to fetch user with the username: \(username)")
                completion(nil)
                return
            }
            
            completion(user)
        }
    }
    
    func logoutUser(completion: @escaping (Bool) -> Void) {
        
        do {
            try FirebaseManager.auth.signOut()
            loggedInUser = nil
            completion(true)
        } catch let error {
            print("Error: Could not sign out \n\(#function)\n\(error)\n\(error.localizedDescription)")
            completion(false)
        }
    }
}
