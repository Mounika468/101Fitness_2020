//
//  WorkOutDays.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

/// Struct that contains the availabiliity for a date, and the corresponding slots.
struct WorkOutWeeks: Decodable {
    let week: Int
    var days: [WorkOutDays]?
    
    init(week: Int) {
        
        self.week = week
      //  self.days = days
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        week = try container.decode(Int.self, forKey: .week)
        days = try container.decodeIfPresent([WorkOutDays].self, forKey: .days)
    }
    
    
}
extension WorkOutWeeks {
    
    enum CodingKeys: String, CodingKey {
        
        case week
        case days
        
        
    }
}
