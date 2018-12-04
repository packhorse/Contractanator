//
//  User.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

struct User {
    
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let phone: String
    let password: String
    var jobListings: [JobListing]? {
        
//        let listings = JoblistingController.shared.jobListings
        return nil
    }
}
