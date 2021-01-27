//
//  TrainerIntro.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 08/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct TrainerInfo: Decodable {
    let trainerId: String
    let firstName: String?
    let lastName: String?
    var profileImage: ProfileImage?
    let rating: Float?
    
    init(trainerId: String,
         firstName: String?,
         lastName: String?,
         rating: Float?) {
        
        self.trainerId = trainerId
        self.firstName = firstName
        self.lastName = lastName
        self.rating = rating
      //  self.rating = rating
       // self.new = new
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trainerId = try container.decode(String.self, forKey: .trainerId)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.profileImage = try container.decodeIfPresent(ProfileImage.self, forKey: .profileImage)
        self.rating = try container.decodeIfPresent(Float.self, forKey: .rating)
      //  self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
      //  self.new = try container.decodeIfPresent(Bool.self, forKey: .new)
       // self.profileIntroVideo = try container.decodeIfPresent(IntroVideo.self, forKey: .profileIntroVideo)
        
    }
   
}
extension TrainerInfo {
       
       enum CodingKeys: String, CodingKey {
           
           case trainerId
           case firstName
           case lastName
        //   case profileIntroVideo
           case profileImage
           case rating
           case new
           
       }
   }
//struct IntroVideo: Codable {
//    let id: Int?
//     let name: String?
//    let imgUrl: String?
//
//    init(id: Int?,
//         name: String?,
//         imgUrl: String?) {
//        self.id = id
//         self.name = name
//        self.imgUrl = imgUrl
//    }
//
//    init(from decoder: Decoder) throws {
//           let container = try decoder.container(keyedBy: CodingKeys.self)
//           self.id = try container.decodeIfPresent(Int.self, forKey: .id)
//        self.name = try container.decodeIfPresent(String.self, forKey: .name)
//        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
//       }
//}
struct ProfileImage: Codable {
    let profileImageName: String?
     let profileImagePath: String?
    
    init(profileImageName: String?,
         profileImagePath: String?) {
        self.profileImageName = profileImageName
         self.profileImagePath = profileImagePath
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.profileImageName = try container.decodeIfPresent(String.self, forKey: .profileImageName)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
       }
}
