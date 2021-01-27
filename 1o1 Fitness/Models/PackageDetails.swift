//
//  PackageDetails.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 30/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct PackageDetails: Codable {
    let programId: String?
    let programName: String?
    let priceInDollars: Double?
    let priceInRupees: Double?
    let trainerId: String?
    let plans: Int?
    let weeks: Int?
     let programDuration: Int?
    var currency : [Currency]?
     var packageType: PackageType?
    let description : String?
    let startDate: String?
     let enrollmentDate: String?
    var nutrition : Nutrition?
    let isSubscribed : Bool?
    let isAnyActiveProgram: Bool?
    init(programId: String?,
         programName: String?,
         priceInDollars: Double?,
         priceInRupees: Double?,
         trainerId: String?,
         plans: Int?,
         weeks: Int?,
         programDuration: Int?,
         description:String?,
         startDate: String?,
         enrollmentDate:String?,
         isSubscribed : Bool?,
         isAnyActiveProgram: Bool?) {
        self.programId = programId
         self.programName = programName
        self.priceInDollars = priceInDollars
        self.trainerId = trainerId
        self.plans = plans
         self.weeks = weeks
        self.programDuration = programDuration
        self.description = description
        self.startDate = startDate
        self.enrollmentDate = enrollmentDate
        self.priceInRupees = priceInRupees
        self.isSubscribed = isSubscribed
        self.isAnyActiveProgram = isAnyActiveProgram
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.programId = try container.decodeIfPresent(String.self, forKey: .programId)
        self.programName = try container.decodeIfPresent(String.self, forKey: .programName)
        self.priceInDollars = try container.decodeIfPresent(Double.self, forKey: .priceInDollars)
        self.priceInRupees = try container.decodeIfPresent(Double.self, forKey: .priceInRupees)
        self.trainerId = try container.decodeIfPresent(String.self, forKey: .trainerId)
         self.packageType = try container.decodeIfPresent(PackageType.self, forKey: .packageType)
        self.currency = try container.decodeIfPresent([Currency].self, forKey: .currency)
        self.nutrition = try container.decodeIfPresent(Nutrition.self, forKey: .nutrition)
        self.plans = try container.decodeIfPresent(Int.self, forKey: .plans)
        self.weeks = try container.decodeIfPresent(Int.self, forKey: .weeks)
        self.programDuration = try container.decodeIfPresent(Int.self, forKey: .programDuration)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
         self.startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
         self.enrollmentDate = try container.decodeIfPresent(String.self, forKey: .enrollmentDate)
        self.isSubscribed = try container.decodeIfPresent(Bool.self, forKey: .isSubscribed)
        self.isAnyActiveProgram = try container.decodeIfPresent(Bool.self, forKey: .isAnyActiveProgram)
       }
}
struct Currency: Codable {
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.name = try container.decodeIfPresent(String.self, forKey: .name)
       }
}
struct Nutrition: Codable {
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.name = try container.decodeIfPresent(String.self, forKey: .name)
       }
}
