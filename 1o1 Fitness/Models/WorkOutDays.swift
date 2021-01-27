//
//  WorkOutDays.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
/// Struct that contains the availabiliity for a date, and the corresponding slots.
struct WorkOutDays: Decodable {
    ///Date of availablity
    let day: Int
    /// Availability slots (usually by 15 minute increments)
    var workouts: [WorkOut]?
    
    var cardio: Cardio?
    let rest: Bool
    let progress_photo: Bool
    
    init(day: Int, rest: Bool, progress_photo: Bool) {
        
        self.day = day
        self.rest = rest
        self.progress_photo = progress_photo
    }
    
    init(from decoder: Decoder) throws {
        print("THis is WorkOUtdays")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        day = try container.decode(Int.self, forKey: .day)
        rest = try container.decode(Bool.self, forKey: .rest)
        progress_photo = try container.decode(Bool.self, forKey: .progress_photo)
         self.workouts = try container.decodeIfPresent([WorkOut].self, forKey: .workouts)
         self.cardio = try container.decodeIfPresent(Cardio.self, forKey: .cardio)
    }
    
 
}
extension WorkOutDays {
    
    enum CodingKeys: String, CodingKey {
        
        case day
        case workouts
        case cardio
        case rest
        case progress_photo
        
    }
}

