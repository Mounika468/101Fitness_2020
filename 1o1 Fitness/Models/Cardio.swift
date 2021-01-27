//
//  Cardio.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct Cardio: Codable {
    let id: String?
     let name: String?
    let imgUrl: String?
    var distance: DisplayVal?
    let metrics: String?
    var cardioComments : [Comments]?
    let cardioStatus: String?
    init(id: String?,
         name: String?,
         imgUrl: String?,
         metrics : String?,
         cardioStatus: String?) {
        self.id = id
         self.name = name
        self.imgUrl = imgUrl
       // self.cardioComments = cardioComments
        self.metrics = metrics
         self.cardioStatus = cardioStatus
    }
    
    init(from decoder: Decoder) throws {
        print("Cardio erroe")
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
        self.cardioComments = try container.decodeIfPresent([Comments].self, forKey: .cardioComments)
         self.metrics = try container.decodeIfPresent(String.self, forKey: .metrics)
        self.distance = try container.decodeIfPresent(DisplayVal.self, forKey: .distance)
         self.cardioStatus = try container.decodeIfPresent(String.self, forKey: .cardioStatus)
       }
}
//extension Cardio {
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case imgUrl
//        case distance
//        case metrics
//        case cardioComments
//    }
//}
