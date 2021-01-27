//
//  ProgramsData.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct MyPrograms:Codable {
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
}
            
           
           
