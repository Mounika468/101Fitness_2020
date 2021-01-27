//
//  RemindersModel.swift
//  1o1 Fitness
//
//  Created by Hareen.Pulivarthi on 21/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct Reminders:Codable {
    let trainee_id: String?
    var meal: ReminderType?
    var water: ReminderType?
    var exercise: ReminderType?
    var weight: ReminderType?
    let notifyAll: Bool?
   
}
struct ReminderType: Codable {
    let isNotify: Bool?
}
struct RemindersPostBody: Codable {
    let trainee_id: String
    let meal: ReminderType?
    let water: ReminderType?
    let exercise: ReminderType?
    let weight: ReminderType?
    let notifyAll: Bool
    init(trainee_id:String,
          meal: ReminderType?,
          water: ReminderType?,
          exercise: ReminderType?,
          weight: ReminderType?,
          notifyAll: Bool)  {
        self.trainee_id = trainee_id
        self.meal = meal
        self.exercise = exercise
        self.water = water
        self.weight = weight
        self.notifyAll = notifyAll
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.meal = try container.decodeIfPresent(ReminderType.self, forKey: .meal)
        self.water = try container.decodeIfPresent(ReminderType.self, forKey: .water)
         self.exercise = try container.decodeIfPresent(ReminderType.self, forKey: .exercise)
        self.weight = try container.decodeIfPresent(ReminderType.self, forKey: .weight)
        self.notifyAll = try container.decode(Bool.self, forKey: .notifyAll)
        
    }
}
