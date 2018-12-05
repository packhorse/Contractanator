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
                        hourlyPay: Int, zipCode: String,
                        completion: @escaping (Bool) -> Void) {
        
        // Unwrap the current session's loggedInUser and get their username
        guard let loggedInUser = UserController.shared.loggedInUser else {
            print("Error: no loggedInUser. \n\(#function)")
            completion(false)
            return
        }
        
        let username = loggedInUser.username
        let firstName = loggedInUser.firstName
        let lastName = loggedInUser.lastName
        
        // Initialize an instance of jobListing
        let jobListing = JobListing(withTitle: title, description: description,
                                    jobType: jobType, criteria: criteria,
                                    hourlyPay: hourlyPay, zipCode: zipCode,
                                    username: username, firstName: firstName, lastName: lastName, timestamp: Date())
        
        // Post the document to FireStore
        FirebaseManager.postJobListing(withJobListing: jobListing) { (success) in
            if !success {
                print("Error: unable to successfully post jobListing \n\(#function)")
                completion(false)
                return
            }
            
            // Add the joblisting to the top of the listings array
            self.jobListings.insert(jobListing, at: 0)
            completion(true)
        }
    }
    
    func fetchJobListings(completion: @escaping (Bool) -> Void) {
        
        // Fetch all listings from FireStore within 25 miles
        
        FirebaseManager.db.collection(Constants.jobListingsTypeKey).getDocuments { (result, error) in
            if let error = error {
                print("Error: could not fetch all job listings \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let listingDocs = result?.documents else { completion(false) ; return }
            
            let listings = listingDocs.compactMap({ JobListing(withDict: $0.data()) })
            
            self.jobListings = listings
            completion(true)
        }
    }
    
    func fetchJobListings(ofJobType jobType: JobType, criteria: [JobCriteria], minHourlyPay: Int, completion: @escaping (Bool) -> Void) {
        
        //
    }
}
