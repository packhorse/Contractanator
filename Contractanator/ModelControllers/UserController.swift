//
//  UserController.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

class UserController {
    
    // MARK: - Properties
    
    // Singleton
    static let shared = UserController()
    private init() {}
    
    // Source of Truth
    var loggedInUser: User?
    
    // MARK: - Functions
}
