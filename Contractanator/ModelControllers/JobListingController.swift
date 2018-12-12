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
    
    // Singleton
    static let shared = JobListingController()
    private init() {}
    
    // Source of truth
    var jobListings = [JobListing]() {
        didSet {
            NotificationCenter.default.post(name: Constants.jobListingsDidUpdateNotification, object: nil)
        }
    }
    
    var sortedListings = [JobListing]() {
        didSet {
            NotificationCenter.default.post(name: Constants.sortedListingsDidUpdateNotification, object: nil)
        }
    }
    
    var myListings = [JobListing]() {
        didSet {
            NotificationCenter.default.post(name: Constants.myListingsDidUpdateNotification, object: nil)
        }
    }
    
    var jobTypeFilter: JobType? = nil {
        didSet {
            sortJobListings()
        }
    }
    
    var jobCriteriaFilters = [JobCriteria]() {
        didSet {
            sortJobListings()
        }
    }
    
    var maxBudgetHourlyPayFilter: Int = Constants.maxPaySliderAmount {
        didSet {
            sortJobListings()
        }
    }
    
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
            self.myListings.insert(jobListing, at: 0)
            completion(true)
        }
    }
    
    func fetchAllJobListings(completion: @escaping (Bool) -> Void) {
        
        // Fetch all listings from FireStore within 25 miles
        
        FirebaseManager.db.collection(Constants.jobListingsTypeKey).getDocuments { (result, error) in
            if let error = error {
                print("Error: could not fetch all job listings \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let listingDocs = result?.documents else { completion(false) ; return }
            
            let listings = listingDocs.compactMap({ JobListing(withDict: $0.data()) })
            
            self.jobListings = listings.sorted(by: { $0.jobType.rawValue < $1.jobType.rawValue })
            completion(true)
        }
    }
    
    func sortJobListings() {
        
        var sortedListingsPlaceholder = jobListings.filter({$0.hourlyPay <= maxBudgetHourlyPayFilter})
        
        sortedListings = sortedListingsPlaceholder
        
        if jobCriteriaFilters.count > 0 {
            sortedListingsPlaceholder = sortedListingsPlaceholder.sorted(by: { (a, b) -> Bool in
                
                var counterA = 0
                var counterB = 0
                
                for criteriaFilter in jobCriteriaFilters {
                    if a.criteria.contains(criteriaFilter) {
                        counterA += 1
                    }
                    if b.criteria.contains(criteriaFilter) {
                        counterB += 1
                    }
                }
                
                return counterA >= counterB
            })
        }
        
        if let jobTypeFilter = jobTypeFilter {
            sortedListings = sortedListingsPlaceholder.filter({$0.jobType == jobTypeFilter})
        } else {
            sortedListings = sortedListingsPlaceholder
        }
    }
    
    func getMyListings() {
        
        guard let currentUsername = UserController.shared.loggedInUser?.username else {
            myListings = []
            return
        }
        
        myListings = jobListings.filter { $0.username == currentUsername }
    }
    
    func reportJobListing(withListingID listingID: String, completion: @escaping (Bool) -> Void) {
        
        FirebaseManager.db.collection(Constants.reportedListingsTypeKey).document(listingID).setData([:]) { (error) in
            if let error = error {
                print("Error: could not report the listing \n\(#function)\n\(error)\n\(error.localizedDescription)")
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}
