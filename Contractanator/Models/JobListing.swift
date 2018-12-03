//
//  JobListing.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

struct JobListing {
    
    let title: String
    let description: String
    let jobType: JobType
    let criteria: [JobCriteria]
    let hourlyPay: Int
    let username: String
}
