//
//  CalenderStatus.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 26/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct CalenderStatus: Decodable {
    let calendar_id: String
    let trainee_id: String
    let program_id: String
    var days: [CalenderDays]?
    
    
    init(calendar_id: String,
         trainee_id: String,
         program_id: String)  {
        self.calendar_id = calendar_id
        self.trainee_id = trainee_id
        self.program_id = program_id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.calendar_id = try container.decode(String.self, forKey: .calendar_id)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.days = try container.decodeIfPresent([CalenderDays].self, forKey: .days)
    }
}
extension CalenderStatus {
    
    enum CodingKeys: String, CodingKey {
        case calendar_id
        case trainee_id
        case program_id
        case days
        
    }
}
struct CalenderDays: Codable {
    let date: String
    let dayStatus: String
    let dayPercentage: String
    
    
    init(date: String,
         dayStatus: String,
         dayPercentage: String)  {
        
        self.date = date
        self.dayStatus = dayStatus
        self.dayPercentage = dayPercentage
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.dayStatus = try container.decode(String.self, forKey: .dayStatus)
        self.dayPercentage = try container.decode(String.self, forKey: .dayPercentage)
    }
}
struct CalendarDayColours: Codable {
    let calendarDays: [DaysStatus]?
    let mealplanDays: [DaysStatus]?
}
struct DaysStatus: Codable {
    let date: String?
    let dayStatus: String?
}

