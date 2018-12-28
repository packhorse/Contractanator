//
//  NetworkingErrors.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/3/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

enum SignUpErrors: String {
    case usernameTaken = "Taken"
    case usernameAvailable = "Available"
    case invalidEmail = "Invalid email"
    case tooShort = "Too short"
    case passwordMismatch = "Mismatch"
}

enum SignInErrors: String {
    case emailNotFound = "Email not found"
    case wrongPassword = "Wrong password"
    case tryAgain = "Try again later"
}
