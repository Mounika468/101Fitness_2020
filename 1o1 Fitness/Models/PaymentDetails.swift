//
//  PaymentDetails.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 11/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

struct PaymentDetails: Decodable {
    var address: [Address]?
    let country_id: String
    var currency: [Currency]?
    let first_name: String
     let last_name: String?
    let is_active: Bool
     let payment_type_id: Int
     let key_name: String
    let paymentgateway_name: String
    let paymentgateway_url: String
    let price: Double
    var profile_image: Profile_image?
    let programDuration: Int
    let program_amount: Double
     let program_name: String
     let state_id: String
    let tax1_display_name: String
    let tax1_type : String
    let tax_1: Double
    let tax_amount: Double
    let tax_break_up_id: Int
    let total_amount: Double
    let totalamount_tax: Double
    let access_key: String?
    let currency_id: String?
    init(country_id: String,
         first_name: String,
         last_name: String?,
         is_active: Bool,
         payment_type_id: Int,
         key_name: String,
         paymentgateway_name: String,
         paymentgateway_url: String,
         price: Double,
         programDuration: Int,
         program_amount: Double,
          program_name: String,
           state_id: String,
          tax1_display_name: String,
          tax1_type : String,
          tax_1: Double,
          tax_amount: Double,
          tax_break_up_id: Int,
          total_amount: Double,
          totalamount_tax: Double,
          access_key: String?,
          currency_id: String?)  {
        self.country_id = country_id
        self.first_name = first_name
        self.last_name = last_name
        self.is_active = is_active
        self.payment_type_id = payment_type_id
        self.key_name = key_name
        self.paymentgateway_name = paymentgateway_name
        self.paymentgateway_url = paymentgateway_url
         self.price = price
        self.programDuration = programDuration
        self.program_amount = program_amount
        self.program_name = program_name
        self.state_id = state_id
        self.tax1_display_name = tax1_display_name
        self.tax1_type = tax1_type
        self.tax_1 = tax_1
        self.tax_amount = tax_amount
        self.tax_break_up_id = tax_break_up_id
        self.total_amount = total_amount
        self.totalamount_tax = totalamount_tax
       self.access_key = access_key
        self.currency_id = currency_id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.country_id = try container.decode(String.self, forKey: .country_id)
        self.is_active = try container.decode(Bool.self, forKey: .is_active)
               self.first_name = try container.decode(String.self, forKey: .first_name)
               self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
               self.payment_type_id = try container.decode(Int.self, forKey: .payment_type_id)
               self.key_name = try container.decode(String.self, forKey: .key_name)
               self.paymentgateway_name = try container.decode(String.self, forKey: .paymentgateway_name)
               self.paymentgateway_url = try container.decode(String.self, forKey: .paymentgateway_url)
               self.profile_image = try container.decode(Profile_image.self, forKey: .profile_image)
               self.programDuration = try container.decode(Int.self, forKey: .programDuration)
               self.program_amount = try container.decode(Double.self, forKey: .program_amount)
               self.program_name = try container.decode(String.self, forKey: .program_name)
               self.state_id = try container.decode(String.self, forKey: .state_id)
               self.tax1_display_name = try container.decode(String.self, forKey: .tax1_display_name)
               self.tax1_type = try container.decode(String.self, forKey: .tax1_type)
                self.tax_1 = try container.decode(Double.self, forKey: .tax_1)
               self.tax_amount = try container.decode(Double.self, forKey: .tax_amount)
               self.tax_break_up_id = try container.decode(Int.self, forKey: .tax_break_up_id)
               self.total_amount = try container.decode(Double.self, forKey: .total_amount)
               self.totalamount_tax = try container.decode(Double.self, forKey: .totalamount_tax)
        self.price = try container.decode(Double.self, forKey: .price)
         self.access_key = try container.decodeIfPresent(String.self, forKey: .access_key)
        self.address = try container.decodeIfPresent([Address].self, forKey: .address)
         self.currency = try container.decodeIfPresent([Currency].self, forKey: .currency)
        self.currency_id = try container.decodeIfPresent(String.self, forKey: .currency_id)
            
    }
}
extension PaymentDetails {
    
    enum CodingKeys: String, CodingKey {
        case address
        case country_id
        case currency
        case first_name
        case last_name
        case is_active
        case payment_type_id
        case key_name
        case paymentgateway_name
        case paymentgateway_url
        case price
        case profile_image
        case programDuration
        case program_amount
        case program_name
        case state_id
        case tax1_display_name
        case tax1_type
        case tax_1
        case tax_amount
        case tax_break_up_id
        case total_amount
        case totalamount_tax
         case access_key
        case currency_id
        
    }
}
struct Profile_image : Codable {
    let profileImagePath: String?
}
struct Address: Decodable {


     let id: String?
    let address: String?
    let city: String?
    let country: String?
  //  var latLongAttributes: LatLongAttributes?
     let pincode: String?
    let isPrimary: Bool?
     let state: String?
    let name: String?
      let country_code: String?
      let address_type: String?
      let mobile_number: String?
    let land_mark: String?
     
    init(address: String?,
         id: String?,
         city: String?,
         country: String?,
         pincode: String?,
         isPrimary: Bool?,
         state:String?,
         name: String?,
         country_code: String?,
         address_type: String?,
         mobile_number: String?,
         land_mark: String?)  {
         self.id = id
        self.address = address
        self.city = city
        self.country = country
        self.pincode = pincode
        self.isPrimary = isPrimary
         self.state = state
        self.name = name
               self.country_code = country_code
               self.address_type = address_type
               self.mobile_number = mobile_number
                self.land_mark = land_mark
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
         self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
      //  self.latLongAttributes = try container.decodeIfPresent(LatLongAttributes.self, forKey: .latLongAttributes)
        self.pincode = try container.decodeIfPresent(String.self, forKey: .pincode)
        self.isPrimary = try container.decodeIfPresent(Bool.self, forKey: .isPrimary)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.country_code = try container.decodeIfPresent(String.self, forKey: .country_code)
               self.address_type = try container.decodeIfPresent(String.self, forKey: .address_type)
               self.mobile_number = try container.decodeIfPresent(String.self, forKey: .mobile_number)
               self.land_mark = try container.decodeIfPresent(String.self, forKey: .land_mark)
    }
}
extension Address {
    
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case country
     //   case latLongAttributes
        case pincode
        case isPrimary
        case state
        case id
        case name
        case country_code
        case address_type
        case mobile_number
        case land_mark
        
    }
}
struct OrderDetails: Decodable {
    let order_id: Int
           let payment_id: Int
          let trainee_id: String
         let  program_id: String
         let  order_status: String
       let    order_purchase_date: String
        let   total_amount: Double
         let  amount_without_tax: Double
        let   payment_type_id: Int
          let tax_break_up_id: Int
         let  paymentgateway_order_id: String
         let  created_date_time: String
          let updated_date_time: String
    let stripe_client_secret: String?

     
    init( order_id: Int,
         payment_id: Int,
        trainee_id: String,
        program_id: String,
        order_status: String,
        order_purchase_date: String,
        total_amount: Double,
        amount_without_tax: Double,
        payment_type_id: Int,
        tax_break_up_id: Int,
        paymentgateway_order_id: String,
        created_date_time: String,
        updated_date_time: String,
        stripe_client_secret:String?)  {
        
        self.order_id = order_id
        self.payment_id = payment_id
        self.trainee_id = trainee_id
        self.program_id = program_id
               self.order_status = order_status
               self.order_purchase_date = order_purchase_date
         self.total_amount = total_amount
        
        
        self.amount_without_tax = amount_without_tax
               self.payment_type_id = payment_type_id
               self.tax_break_up_id = tax_break_up_id
                      self.paymentgateway_order_id = paymentgateway_order_id
                      self.created_date_time = created_date_time
                self.updated_date_time = updated_date_time
        self.stripe_client_secret = stripe_client_secret
     
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.order_id = try container.decode(Int.self, forKey: .order_id)
        self.payment_id = try container.decode(Int.self, forKey: .payment_id)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.order_status = try container.decode(String.self, forKey: .order_status)
        self.order_purchase_date = try container.decode(String.self, forKey: .order_purchase_date)
        self.total_amount = try container.decode(Double.self, forKey: .total_amount)
        
        
        self.amount_without_tax = try container.decode(Double.self, forKey: .amount_without_tax)
        self.payment_type_id = try container.decode(Int.self, forKey: .payment_type_id)
        self.tax_break_up_id = try container.decode(Int.self, forKey: .tax_break_up_id)
        self.paymentgateway_order_id = try container.decode(String.self, forKey: .paymentgateway_order_id)
        self.created_date_time = try container.decode(String.self, forKey: .created_date_time)
        self.updated_date_time = try container.decode(String.self, forKey: .updated_date_time)
         self.stripe_client_secret = try container.decodeIfPresent(String.self, forKey: .stripe_client_secret)
    }
}

       
extension OrderDetails {
    
    enum CodingKeys: String, CodingKey {
        case order_id
        case payment_id
        case trainee_id
        case  program_id
        case  order_status
        case    order_purchase_date
        case   total_amount
        case  amount_without_tax
        case   payment_type_id
        case tax_break_up_id
        case  paymentgateway_order_id
        case  created_date_time
        case updated_date_time
        case stripe_client_secret
    }
}
//MARK: To parse Display Values
struct LatLongAttributes: Codable {
    let latitude: String?
    var longitude: String?
    
    
    init(latitude: String?,
         completed: String?)  {
        
        self.latitude = latitude
        self.longitude = completed
        
    }
    init(from decoder: Decoder) throws {
        print("LatLongAttributes erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
    }
}
