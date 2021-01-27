//
//  CountriesInfo.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 09/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct CountriesInfo: Codable {
    let country_id: String?
     let sortname: String?
    let name: String?
    let phoneCode: Int?
    
    init(country_id: String?,
         sortname: String?,
         name:String?,
         phoneCode: Int?) {
        self.country_id = country_id
         self.sortname = sortname
        self.name = name
                self.phoneCode = phoneCode
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.country_id = try container.decodeIfPresent(String.self, forKey: .country_id)
        self.sortname = try container.decodeIfPresent(String.self, forKey: .sortname)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
               self.phoneCode = try container.decodeIfPresent(Int.self, forKey: .phoneCode)

       }
}
struct StatesInfo: Codable {
    let state_id: String?
     let name: String?
    let country_id: String?
    
    init(state_id: String?,
         name: String?,
        country_id: String?) {
        self.state_id = state_id
         self.name = name
        self.country_id = country_id
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.state_id = try container.decodeIfPresent(String.self, forKey: .state_id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.country_id = try container.decodeIfPresent(String.self, forKey: .country_id)

       }
}
