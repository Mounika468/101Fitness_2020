//
//  ProgramsData.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct MyPrograms: Codable {
    
    var fitness: [ProgramData]?
    var yoga: [ProgramData]?
}
struct ProgramData:Codable {
    let programId: String?
    let programName: String?
     let order_id: Int?
    let invoice_id: Int?
    let daysLeft: Int?
   let programDuration: Int?
    let trainerId: String?
    let program_start_date: String?
    let program_end_date: String?
     var programImg: ProgramImg?
    let isProgramActive: Bool?
    let isRatingSubmitted: Bool?
}
struct ProgramImg:Codable {
    let imgPath: String?
}
struct MyProgramsDetails:Codable {
  let  order_id: Int?
        let   invoice_id: Int?
         let  invoice_number: String?
          let invoice_date: String?
    let paymentgateway_order_id: String?
         let  payment_id: Int?
        //  let invoice_status: cap_1o1_pg_success,
         let  total_amount: Double?
          let tax_break_up_id: Int?
          let tax_amount: Double?
          let discount_amount: Double?
         let  name: String?
          let email: String?
         let  phoneNumber: String?
          let programDuration: Int?
          let program_start_date: String?
         let  price: Double?
         let  currencyPaidIn: String?
         let programName: String?
    
}
struct MyOrders:Codable {
    let programId: String?
    let programName: String?
     let order_id: Int?
    let invoice_id: Int?
    let daysLeft: Int?
   let programDuration: Int?
    let trainerId: String?
    let program_start_date: String?
    let program_end_date: String?
     var programImg: ProgramImg?
    let price: Double?
    var currency: [Currency]?
    let description:String?
    let trainerName:String?
    let currencyPaidIn:String?
    let enableRefund: Bool?
    let status: String?
}


struct RatingsPostBody: Codable {
    let trainee_id: String
   let program_rating: Double
    let trainer_rating: Double
   let review_comment:String
    let commentDate : String
  
    init(trainee_id:String,
         program_rating: Double,
         trainer_rating: Double,
         review_comment: String,
         commentDate:String)  {
        self.trainee_id = trainee_id
        self.program_rating = program_rating
        self.trainer_rating = trainer_rating
        self.review_comment = review_comment
        self.commentDate = commentDate
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.program_rating = try container.decode(Double.self, forKey: .program_rating)
        self.trainer_rating = try container.decode(Double.self, forKey: .trainer_rating)
         self.review_comment = try container.decode(String.self, forKey: .review_comment)
        self.commentDate = try container.decode(String.self, forKey: .commentDate)
        
    }
}
           
