//
//  WorkOut.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 10/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct WorkOut: Codable {
    let id: String?
     let name: String?
    let percentage : String?
    let viewed:String?
    
    init(id: String?,
         name: String?,
         percentage : String?,
         viewed : String?) {
        self.id = id
         self.name = name
        self.percentage = percentage
        self.viewed = viewed
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.id = try container.decodeIfPresent(String.self, forKey: .id)
           self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.percentage = try container.decodeIfPresent(String.self, forKey: .percentage)
        self.viewed = try container.decodeIfPresent(String.self, forKey: .viewed)
       }
}

