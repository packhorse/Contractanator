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
    var uuid: String?
    
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
            Constants.usernameKey : username
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
