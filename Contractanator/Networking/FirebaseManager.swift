//
//  FirebaseManager.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/4/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let db = Firestore.firestore()
    static let auth = Auth.auth()
    
    // MARK: - User Object Firebase Functions
    
    static func createFirebaseUser(withEmail email: String, password: String, completion: @escaping (String?) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Error: could not create user \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Unwrap the user from the result of the auth call
            guard let firebaseUser = authResult?.user else {completion(nil) ; return }
            
            // Pass in the userID to the completion
            completion(firebaseUser.uid)
        }
    }
    
    static func signInExistingUser(withEmail email: String, password: String, completion: @escaping (User?) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Error: could not authenticate user credentials \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Unwrap the authResult and get the userID off of it
            guard let firebaseUser = authResult?.user else { completion(nil) ; return }
            
            // Fetch the user profile and pass in the completion
            fetchCurrentUserProfile(completion: completion)
        }
    }
    
    static func createUserProfile(withUser user: User, completion: @escaping (Bool) -> Void) {
        
        db.collection(Constants.usersTypeKey).document(user.userID).setData(user.getDocData()) { (error) in
            if let error = error {
                print("Error: Could not save the user profile to Firestore \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(false)
                return
            }
            
            print("Successful save of the user to Firestore!!")
            completion(true)
        }
    }
    
    static func fetchCurrentUserProfile(completion: @escaping (User?) -> Void) {
        
        guard let userID = FirebaseManager.auth.currentUser?.uid else {
            print("Error: could not find current user \n\(#function)")
            completion(nil)
            return
        }
        
        let docRef = db.collection(Constants.usersTypeKey).document(userID)
        docRef.getDocument { (document, error) in
            if let error = error {
                print("Error: Something went wrong fetching the user profile \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists, let docData = document.data() else {
                print("No document exists or no document data could be found")
                completion(nil)
                return
            }
            
            let user = User(withDict: docData)
            completion(user)
        }
    }
    
    static func fetchUserProfile(withUsername username: String, completion: @escaping (User?) -> Void) {
        
        // Create a reference to the users collection
        let usersRef = db.collection(Constants.usersTypeKey)
        
        // Create a query against the collection
        let query = usersRef.whereField(Constants.usernameKey, isEqualTo: username)
        
        query.getDocuments { (queryResult, error) in
            if let error = error {
                print("Error: Something went wrong fetching the user profile by username \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let userDoc = queryResult?.documents.first, userDoc.exists else {
                print("No document exists")
                completion(nil)
                return
            }
            
            let user = User(withDict: userDoc.data())
            completion(user)
        }
    }
    
    // MARK: - JobListing Object Firebase Functions
    
    static func postJobListing(withJobListing listing: JobListing, completion: @escaping (Bool) -> Void) {
        
        db.collection(Constants.jobListingsTypeKey).document(listing.listingID).setData(listing.getDocData()) { (error) in
            if let error = error {
                print("Error: unable to post the job listing doc to firestore \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    static func fetchAllJobListings(completion: @escaping ([JobListing]) -> Void) {
        
//        let documents = db
    }
}
