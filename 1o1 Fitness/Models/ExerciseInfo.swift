//
//  ExerciseInfo.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 12/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct ExerciseInfo: Codable {
    let fileId: String?
    let exerciseName: String?
     let exerciseId: String?
    let userId: String?
    let setsVal: Int?
    let weightsVal: Int?
    let repsVal: Int?
    let restPeriodVal: Int?
     let instructions: String?
    let mp4Destination: String?
     let thumbnailDestination: String?
    
    init(fileId: String?,
         exerciseName: String?,
         exerciseId: String?,
         userId: String?,
         setsVal: Int?,
         weightsVal: Int?,
         repsVal: Int?,
         restPeriodVal: Int?,
         instructions:String?,
         mp4Destination: String?,
         thumbnailDestination:String?) {
        
        self.fileId = fileId
        self.exerciseName = exerciseName
        self.exerciseId = exerciseId
        self.userId = userId
        self.setsVal = setsVal
        self.weightsVal = weightsVal
        self.restPeriodVal = restPeriodVal
        self.instructions = instructions
        self.repsVal = repsVal
        self.mp4Destination = mp4Destination
        self.thumbnailDestination = thumbnailDestination
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fileId = try container.decodeIfPresent(String.self, forKey: .fileId)
        self.exerciseName = try container.decodeIfPresent(String.self, forKey: .exerciseName)
        self.exerciseId = try container.decodeIfPresent(String.self, forKey: .exerciseId)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.setsVal = try container.decodeIfPresent(Int.self, forKey: .setsVal)
        self.weightsVal = try container.decodeIfPresent(Int.self, forKey: .weightsVal)
        self.restPeriodVal = try container.decodeIfPresent(Int.self, forKey: .restPeriodVal)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        self.thumbnailDestination = try container.decodeIfPresent(String.self, forKey: .thumbnailDestination)
        self.repsVal = try container.decodeIfPresent(Int.self, forKey: .repsVal)
        self.mp4Destination = try container.decodeIfPresent(String.self, forKey: .mp4Destination)
    }
}
