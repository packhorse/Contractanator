//
//  JobListing.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

struct JobListing {
    
    // MARK: - Properties
    
    let title: String
    let description: String
    let jobType: JobType
    let criteria: [JobCriteria]
    let hourlyPay: Int
    let zipCode: String
    let username: String
    let firstName: String
    let lastName: String
    let timestamp: Date
    let listingID: String
    
    // MARK: - Initializers
    
    init(withTitle title: String, description: String, jobType: JobType, criteria: [JobCriteria],
         hourlyPay: Int, zipCode: String, username: String, firstName: String, lastName: String,
         timestamp: Date = Date(), listingID: String = UUID().uuidString) {
        
        self.title = title
        self.description = description
        self.jobType = jobType
        self.criteria = criteria
        self.hourlyPay = hourlyPay
        self.zipCode = zipCode
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.timestamp = timestamp
        self.listingID = listingID
    }
    
    init?(withDict dict: [String : Any]) {
        
        guard let title = dict[Constants.titleKey] as? String,
            let description = dict[Constants.descriptionKey] as? String,
            let jobTypeAsString = dict[Constants.jobTypeKey] as? String,
            let jobType = JobType(rawValue: jobTypeAsString),
            let criteriaAsStringArray = dict[Constants.criteriaKey] as? [String],
            let hourlyPay = dict[Constants.hourlyPayKey] as? Int,
            let zipCode = dict[Constants.zipCodeKey] as? String,
            let username = dict[Constants.usernameKey] as? String,
            let firstName = dict[Constants.firstNameKey] as? String,
            let lastName = dict[Constants.lastNameKey] as? String,
            let timestamp = dict[Constants.timestampKey] as? Date,
            let listingID = dict[Constants.listingIDKey] as? String
            else { print("Error initializing jobListing type from dictionary") ; return nil }
        
        let criteria = criteriaAsStringArray.compactMap({ JobCriteria(rawValue: $0) })
        
        self.init(withTitle: title, description: description, jobType: jobType, criteria: criteria, hourlyPay: hourlyPay, zipCode: zipCode, username: username, firstName: firstName, lastName: lastName, timestamp: timestamp, listingID: listingID)
    }
    
    // MARK: - Functions
    
    /// Returns a String to Any dictionary for use as firestore document data
    func getDocData() -> [String : Any] {
        
        let criteriaAsStringArray = criteria.map({ $0.rawValue })
        
        let docData: [String : Any] = [
            Constants.titleKey : title,
            Constants.descriptionKey : description,
            Constants.jobTypeKey : jobType.rawValue,
            Constants.criteriaKey : criteriaAsStringArray,
            Constants.zipCodeKey : zipCode,
            Constants.usernameKey : username,
            Constants.firstNameKey : firstName,
            Constants.lastNameKey : lastName,
            Constants.timestampKey : timestamp,
            Constants.listingIDKey : listingID
        ]
        
        return docData
    }
}

// MARK: - Enumerations

enum JobType: String {
    
    case generalContracting
    case electrical
    case handyman
    case interiorDesign
    case homeRenovation
    case landscaping
}

enum JobCriteria: String {
    
    case highQuality
    case specialized
    case fast
    case experienced
    case affordable
    case fullTeam
}
