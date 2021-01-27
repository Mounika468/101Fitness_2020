//
//  TrainerPackage.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 21/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct TrainerPackage: Decodable {
    var beginner: [Beginner]?
    var intermediate: [Intermediate]?
    var advanced: [Advanced]?
   
    
    init() {
         print("before")
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.beginner = try container.decode([Beginner].self, forKey: .beginner)
        self.intermediate = try container.decodeIfPresent([Intermediate].self, forKey: .intermediate)
        self.advanced = try container.decodeIfPresent([Advanced].self, forKey: .advanced)
        
    }
}

extension TrainerPackage {
    enum CodingKeys: String, CodingKey {
        case beginner
        case intermediate
        case advanced
    }
}
struct PackageType: Codable {
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.name = try container.decodeIfPresent(String.self, forKey: .name)
       }
}
struct Beginner: Codable {
    let programId: String?
     let programName: String?
    let priceInDollars: Double?
    let priceInRupees: Double?
    let trainerId: String?
     var packageType: PackageType?
     var currency : [Currency]?
    init(programId: String?,
         programName: String?,
         priceInDollars: Double?,
         priceInRupees: Double?,
         trainerId: String?) {
        self.programId = programId
         self.programName = programName
        self.priceInDollars = priceInDollars
        self.priceInRupees = priceInRupees
        self.trainerId = trainerId
        
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.programId = try container.decodeIfPresent(String.self, forKey: .programId)
        self.programName = try container.decodeIfPresent(String.self, forKey: .programName)
        print("before")
        self.priceInDollars = try container.decodeIfPresent(Double.self, forKey: .priceInDollars)
        self.priceInRupees = try container.decodeIfPresent(Double.self, forKey: .priceInRupees)
         print("after")
        self.trainerId = try container.decodeIfPresent(String.self, forKey: .trainerId)
         self.packageType = try container.decodeIfPresent(PackageType.self, forKey: .packageType)
        self.currency = try container.decodeIfPresent([Currency].self, forKey: .currency)
       }
}
struct Intermediate: Codable {
     let programId: String?
        let programName: String?
    let priceInDollars: Double?
    let priceInRupees: Double?
       let trainerId: String?
        var packageType: PackageType?
        var currency : [Currency]?
       init(programId: String?,
            programName: String?,
            priceInDollars: Double?,
            priceInRupees: Double?,
            trainerId: String?) {
           self.programId = programId
            self.programName = programName
        self.priceInDollars = priceInDollars
        self.priceInRupees = priceInRupees
           self.trainerId = trainerId
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
          }
}
struct Advanced: Codable {
    let programId: String?
        let programName: String?
    let priceInDollars: Double?
    let priceInRupees: Double?
       let trainerId: String?
        var packageType: PackageType?
        var currency : [Currency]?
       init(programId: String?,
            programName: String?,
            priceInDollars: Double?,
            priceInRupees: Double?,
            trainerId: String?) {
           self.programId = programId
            self.programName = programName
        self.priceInDollars = priceInDollars
        self.priceInRupees = priceInRupees
           self.trainerId = trainerId
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
          }
}
