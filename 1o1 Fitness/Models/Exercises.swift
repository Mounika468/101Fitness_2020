//
//  Exercises.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 12/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct Exercises: Codable {
    let exerciseName: String?
    let exerciseId: String?
     let setsVal: Int?
    let repsVal: Int?
    let restPeriodVal: Int?
    let thumbnailDestination: String?
    
    init(setsVal: Int?,
         repsVal: Int?,
         restPeriodVal : Int?,
         exerciseName: String?,
         exerciseId: String?,
         thumbnailDestination: String?) {
        self.setsVal = setsVal
        self.repsVal = repsVal
        self.restPeriodVal = restPeriodVal
        self.exerciseName = exerciseName
        self.exerciseId = exerciseId
        self.thumbnailDestination = thumbnailDestination
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.setsVal = try container.decodeIfPresent(Int.self, forKey: .setsVal)
        self.repsVal = try container.decodeIfPresent(Int.self, forKey: .repsVal)
        self.restPeriodVal = try container.decodeIfPresent(Int.self, forKey: .restPeriodVal)
        self.exerciseName = try container.decodeIfPresent(String.self, forKey: .exerciseName)
         self.exerciseId = try container.decodeIfPresent(String.self, forKey: .exerciseId)
        self.thumbnailDestination = try container.decodeIfPresent(String.self, forKey: .thumbnailDestination)
       }
}
