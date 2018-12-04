//
//  JobListingController.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

class JobListingController {
    
    // MARK: - Properties
    //comment
    
    // Singleton
    static let shared = JobListingController()
    private init() {}
    
    // Source of truth
    var jobListings = [JobListing]()
    
    // MARK: - Functions
    
    func postJobListing(withTitle title: String, description: String,
                        jobType: JobType, criteria: [JobCriteria],
                        hourlyPay: Int, zipCode: Int,
                        completion: @escaping (Bool) -> Void) {
        
        // Unwrap the current session's loggedInUser and get their username
        guard let loggedInUser = UserController.shared.loggedInUser else {
            print("Error: no loggedInUser.\n\(#function)")
            completion(false)
            return
        }
    
        let username = loggedInUser.username
        
        // Initialize an instance of jobListing
        let jobListing = JobListing(title: title, description: description, jobType: jobType, criteria: criteria, hourlyPay: hourlyPay, zipCode: zipCode, username: username)
        
//        temporarily add it to the jobListings array
        jobListings.append(jobListing)
        completion(true)
        
        // Create a firestore document
        
        // Post the document to FireStore
    }
    
    func fetchJobListings(completion: @escaping (Bool) -> Void) {
        
        // Fetch all listings from FireStore within 25 miles
        
        completion(true)
    }
    
    func fetchJobListings(withCriteria criteria: [JobCriteria], completion: @escaping (Bool) -> Void) {
        
        //
    }
}
