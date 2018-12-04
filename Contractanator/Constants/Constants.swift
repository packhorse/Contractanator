//
//  Constants.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: - Type Keys
    
    // Used for the names of the firestore collections
    static let usersTypeKey = "users"
    static let jobListingsTypeKey = "jobListings"
    
    // MARK: - JobListing Keys
    
    // Used for the keys in firestore documents
    static let titleKey = "title"
    static let descriptionKey = "description"
    static let jobTypeKey = "jobType"
    static let criteriaKey = "criteria"
    static let hourlyPayKey = "hourlyPay"
    static let zipCodeKey = "zipCode"
    static let usernameKey = "username"
    
    // MARK: - User Keys
    
    // Used for the keys in firestore documents
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let emailKey = "email"
    static let phoneKey = "phone"
    static let passwordKey = "password"
}
