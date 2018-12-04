//
//  LocationManager.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/4/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
    
    // MARK: - Properties
    
    // Singleton
    static let shared = LocationManager()
    private init() {}
    
    let lm = CLLocationManager()
}

// Request while-in-use authorization at the time that the user needs to use location services


