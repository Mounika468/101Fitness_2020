//
//  ReachabilityService.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 03/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import Reachability

/// Service to wrap underlying Reachability
final class ReachabilityService {
    
    /// Shared Instance of Reachability
    static let shared = ReachabilityService()
    
    /**
     Gets a reachability object for the base URL
     
     - returns: A reachability object if one is able to be created
     */
    func getReachability() -> Reachability? {
        
        return try? Reachability()
    }
}
