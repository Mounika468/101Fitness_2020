//
//  WorkOutExercises.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 12/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct WorkOutLists: Decodable {
    let fileId: String
    let workoutId: String
    let userId: String
    let customWorkoutName: String?
    var workoutExercises: [Exercises]?
    
    
    init(fileId: String,
         workoutId: String,
         userId: String,
         customWorkoutName: String?)  {
        
        self.fileId = fileId
        self.workoutId = workoutId
        self.userId = userId
        self.customWorkoutName = customWorkoutName
     
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fileId = try container.decode(String.self, forKey: .fileId)
        self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.customWorkoutName = try container.decodeIfPresent(String.self, forKey: .customWorkoutName)
        self.workoutExercises = try container.decodeIfPresent([Exercises].self, forKey: .workoutExercises)
    }
}
extension WorkOutLists {
    
    enum CodingKeys: String, CodingKey {
        case fileId
        case workoutId
        case userId
        case customWorkoutName
        case workoutExercises
        
    }
}

