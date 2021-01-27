//
//  ContactUsModel.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 04/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct ContactUs:Codable {
    let id: String?
    let name: String?
    let isShow:Bool?
}
struct ContactusResponse: Codable {
    var values: [ContactUs]?
}
struct ContactUsPostBody: Codable {
    let comments: String
   let os_version: String
    let app_version: String
   let devise_model:String
    let raisedBy : String
    let requestType:String
    let currentDateTime:String
    init(comments:String,
         os_version: String,
         app_version: String,
         devise_model: String,
         currentDateTime:String,
         raisedBy : String,
          requestType:String)  {
        self.comments = comments
        self.os_version = os_version
        self.app_version = app_version
        self.devise_model = devise_model
        self.currentDateTime = currentDateTime
        self.raisedBy = raisedBy
        self.requestType = requestType
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.comments = try container.decode(String.self, forKey: .comments)
        self.os_version = try container.decode(String.self, forKey: .os_version)
        self.app_version = try container.decode(String.self, forKey: .app_version)
         self.devise_model = try container.decode(String.self, forKey: .devise_model)
        self.currentDateTime = try container.decode(String.self, forKey: .currentDateTime)
        self.raisedBy = try container.decode(String.self, forKey: .raisedBy)
       self.requestType = try container.decode(String.self, forKey: .requestType)
        
    }
}
