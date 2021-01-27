//
//  Calender.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct TraineeCalender: Decodable {
    let userId: String?
    let programId: String?
    let startDate: String?
    let calenderId: String?
    let programStartDate: String?
    var days: [WorkOutWeeks]?
    let traineeCalenderId: String?
    
    init(userId: String?,
         programId: String?,
         startDate: String?,
         calenderId: String?,
         programStartDate: String?,
         traineeCalenderId: String?)  {
        
        self.userId = userId
        self.programId = programId
        self.startDate = startDate
        self.calenderId = calenderId
        self.programStartDate = programStartDate
        self.traineeCalenderId = traineeCalenderId
     
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.programId = try container.decode(String.self, forKey: .programId)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.calenderId = try container.decode(String.self, forKey: .calenderId)
         self.programStartDate = try container.decode(String.self, forKey: .programStartDate)
         self.traineeCalenderId = try container.decode(String.self, forKey: .traineeCalenderId)
        self.days = try container.decodeIfPresent([WorkOutWeeks].self, forKey: .days)
    }
}
extension TraineeCalender {
    
    enum CodingKeys: String, CodingKey {
        
        case userId
        case programId
        case startDate
        case calenderId
        case programStartDate
        case traineeCalenderId
        case days
        
    }
}
