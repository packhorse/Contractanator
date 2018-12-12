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
    static let reportedListingsTypeKey = "reportedListings"
    
    // MARK: - JobListing Keys
    
    // Used for the keys in firestore documents
    static let titleKey = "title"
    static let descriptionKey = "description"
    static let jobTypeKey = "jobType"
    static let criteriaKey = "criteria"
    static let hourlyPayKey = "hourlyPay"
    static let zipCodeKey = "zipCode"
    static let usernameKey = "username"
    static let timestampKey = "timestamp"
    static let listingIDKey = "listingID"
    
    // MARK: - User Keys
    
    // Used for the keys in firestore documents
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let phoneKey = "phone"
    static let bioKey = "bio"
    static let userIDKey = "userID"
    
    // MARK: - Notification Names
    
    static let jobListingsDidUpdateNotification = NSNotification.Name("jobListingsDidUpdateNotification")
    static let sortedListingsDidUpdateNotification = NSNotification.Name("sortedListingsDidUpdateNotification")
    static let myListingsDidUpdateNotification = NSNotification.Name("myListingsDidUpdateNotification")
    
    // MARK: - UIColor Asset Names
    
    static let coolBlue = "CoolBlue"
    static let coolOrange = "CoolOrange"
    static let grassyGreen = "GrassyGreen"
    static let popsiclePurple = "PopsiclePurple"
    static let rudeRed = "RudeRed"
    static let urineYellow = "UrineYellow"

    // MARK: - Maximum Slider Amount
    static let maxPaySliderAmount = 200
}
