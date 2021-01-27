//
//  CallModel.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 11/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct PostSchedule: Codable {
    let date: String
   let trainee_id: String
    init(
         date:String,
         trainee_id: String)  {
        self.date = date
        self.trainee_id = trainee_id
       
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
       
    }
}
struct PostSlot: Codable {
    let slotId: String
     let schedulerId: String
   let trainee_id: String
    init(slotId:String,
         trainee_id: String,
         schedulerId:String)  {
        self.slotId = slotId
        self.trainee_id = trainee_id
        self.schedulerId = schedulerId
       
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.schedulerId = try container.decode(String.self, forKey: .schedulerId)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.slotId = try container.decode(String.self, forKey: .slotId)
       
    }
}

struct SchedulesData: Codable {
    var slots: [SlotsData]?
}
struct SlotsData:Codable {
    let firstName: String?
    let lastName: String?
    let slotId: String?
    let startTime: String?
     let endTime: String?
    let status: String?
    let programName: String?
    let roomName: String?
    let endDateTime: String?
    let startDateTime: String?
     var participants: [Participants]?
    var frequency: Frequency?
    var profileImage: ProfileImages?
    let callType: String?
}
struct RoomToken:Codable {
    
    let roomName: String?
     var token: String?
}
struct ProfileImages:Codable {
    let profileImagePath: String?
   
}
struct Frequency:Codable {
    let name: String?
   
}
struct TwilioToken:Codable {
    let token: String?
    let roomName: String?
   
}
struct Participants:Codable {
    let trainee_id: String?
    
}
