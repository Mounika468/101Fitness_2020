//
//  TrainerProfile.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 21/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct TrainerProfile: Decodable {
    let trainerId: String
    let firstName: String?
    let lastName: String?
    var profileImage: ProfileImage?
    let rating: Float?
    let about: String?
    var certification: [Certification]?
    var profileIntroVideo : ProfileIntroVideo?
    init(trainerId: String,
         firstName: String?,
         lastName: String?,
         about: String?,
         rating: Float?) {
        
        self.trainerId = trainerId
        self.firstName = firstName
        self.lastName = lastName
        self.rating = rating
         self.about = about
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.trainerId = try container.decode(String.self, forKey: .trainerId)
           self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
           self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
           self.profileImage = try container.decodeIfPresent(ProfileImage.self, forKey: .profileImage)
           self.rating = try container.decodeIfPresent(Float.self, forKey: .rating)
           self.about = try container.decodeIfPresent(String.self, forKey: .about)
          self.certification = try container.decodeIfPresent([Certification].self, forKey: .certification)
         self.profileIntroVideo = try container.decodeIfPresent(ProfileIntroVideo.self, forKey: .profileIntroVideo)
           
       }
}

extension TrainerProfile {
    
    enum CodingKeys: String, CodingKey {
        
        case trainerId
        case firstName
        case lastName
        case certification
        case profileImage
        case rating
        case about
        case profileIntroVideo
    }
}
struct Certification: Codable {
    let name: String?
     let certificateDestinationUploadUrl: String?
    let uploadedCertificateName: String?
    
    init(name: String?,
         certificateDestinationUploadUrl: String?,
         uploadedCertificateName: String?) {
        self.name = name
         self.certificateDestinationUploadUrl = certificateDestinationUploadUrl
        self.uploadedCertificateName = uploadedCertificateName
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.certificateDestinationUploadUrl = try container.decodeIfPresent(String.self, forKey: .certificateDestinationUploadUrl)
        self.uploadedCertificateName = try container.decodeIfPresent(String.self, forKey: .uploadedCertificateName)
       }
}
struct ProfileIntroVideo: Codable {
    let videoMp4Destination: String?
     let videoThumbnailPath: String?
    
    init(videoMp4Destination: String?,
         videoThumbnailPath: String?) {
        self.videoMp4Destination = videoMp4Destination
         self.videoThumbnailPath = videoThumbnailPath
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.videoMp4Destination = try container.decodeIfPresent(String.self, forKey: .videoMp4Destination)
        self.videoThumbnailPath = try container.decodeIfPresent(String.self, forKey: .videoThumbnailPath)

       }
}
