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
    
    static func createFirebaseUser(withEmail email: String, password: String, completion: @escaping (String?) -> Void){
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Error: could not create user \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Unwrap the user from the result of the auth call
            guard let user = authResult?.user else { return }
            
            // Pass in the userID to the completion
            completion(user.uid)
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
    
    static func fetchUserProfile(completion: @escaping (User?) -> Void) {
        
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
