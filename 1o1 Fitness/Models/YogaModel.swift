//
//  YogaModel.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 30/06/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct YogaModel:Codable {
    
    let day: Int
    var asanas: [Asanas]?
    var cardio : Cardio?
    let rest: Bool?
    let subscription_id: String?
}

struct Asanas: Codable {
    let asanaId: String?
    let asanaTitle: String?
    let asanaStatus: String?
    let asanaPercentage: String?
    var sets: [YogaSets]?
    var asanaVideo : AsanaVideos?
      let benifitsOfAsana: String?
      var instructions: [Instructions]?
      var precautions: String?
   
}
struct AsanaVideos: Codable {
    
    let asanaVideoSource: String?
     let videoThumbnailPath: String?
    let videoMp4Destination: String?
    let videoSourceUrl: String?
}

struct Instructions: Codable {
    let name: String?
    
}
struct Info: Codable {
    let name: String?
    
}
struct YogaSets: Codable {
    let setNo: Int
    var reputationValue: DisplayVal?
    var breathValue: DisplayVal?
    var minutesPeriod: DisplayVal?
}
