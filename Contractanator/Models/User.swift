//
//  User.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

struct User {
    
    // MARK: - Properties
    
    let firstName: String
    let lastName: String
    let username: String
    let phone: String
    let userID: String
    var jobListings: [JobListing]? {
        
//        let listings = JoblistingController.shared.jobListings
        return nil
    }
    
    // MARK: - Initializers
    
    init(firstName: String, lastName: String, username: String, phone: String, userID: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.phone = phone
        self.userID = userID
    }
    
    init?(withDict dict: [String : Any]) {
        
        guard let firstName = dict[Constants.firstNameKey] as? String,
            let lastName = dict[Constants.lastNameKey] as? String,
            let username = dict[Constants.usernameKey] as? String,
            let phone = dict[Constants.phoneKey] as? String,
            let userID = dict[Constants.userIDKey] as? String
            else { print("Error initializing User type from dictionary") ; return nil }
        
        self.init(firstName: firstName, lastName: lastName, username: username, phone: phone, userID: userID)
    }
    
    // MARK: - Functions
    
    func getDocData() -> [String : Any] {
        
        let docData: [String : Any] = [
            Constants.firstNameKey : firstName,
            Constants.lastNameKey : lastName,
            Constants.usernameKey : username,
            Constants.phoneKey : phone,
            Constants.userIDKey : userID
        ]
        
        return docData
    }
}
