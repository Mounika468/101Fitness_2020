//
//  TrainerVideos.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 22/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct TrainerVideoList: Decodable {
    let trainerId: String
    let exerciseName: String?
    var exerciseVideo: ExerciseVideo?
    let exerciseId: String?
    
    init(trainerId: String,
         exerciseName: String?,
         exerciseId: String?) {
        
        self.trainerId = trainerId
        self.exerciseName = exerciseName
        self.exerciseId = exerciseId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trainerId = try container.decode(String.self, forKey: .trainerId)
        self.exerciseName = try container.decodeIfPresent(String.self, forKey: .exerciseName)
        self.exerciseVideo = try container.decodeIfPresent(ExerciseVideo.self, forKey: .exerciseVideo)
        self.exerciseId = try container.decodeIfPresent(String.self, forKey: .exerciseId)
        
    }
}
extension TrainerVideoList {
    enum CodingKeys: String, CodingKey {
        case trainerId
        case exerciseName
        case exerciseVideo
        case exerciseId
    }
}
struct ExerciseVideo: Codable {
    let exerciseVideoSource: String?
     let videoThumbnailPath: String?
    let videoMp4Destination: String?
    let videoSourceUrl: String?
    
    init(exerciseVideoSource: String?,
         videoThumbnailPath: String?,
         videoMp4Destination: String?,
         videoSourceUrl: String?) {
        self.exerciseVideoSource = exerciseVideoSource
         self.videoThumbnailPath = videoThumbnailPath
        self.videoMp4Destination = videoMp4Destination
        self.videoSourceUrl = videoSourceUrl
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.exerciseVideoSource = try container.decodeIfPresent(String.self, forKey: .exerciseVideoSource)
        self.videoThumbnailPath = try container.decodeIfPresent(String.self, forKey: .videoThumbnailPath)
        self.videoMp4Destination = try container.decodeIfPresent(String.self, forKey: .videoMp4Destination)
               self.videoSourceUrl = try container.decodeIfPresent(String.self, forKey: .videoSourceUrl)
       }
}
