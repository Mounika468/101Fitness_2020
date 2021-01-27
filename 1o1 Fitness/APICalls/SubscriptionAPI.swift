//
//  SubscriptionAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 28/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class SubscriptionAPI: API
{
  
    static func postSubscription(parameters: [String: Any],header:[String: String],dataParams:Data,
                        successHandler: @escaping (PaymentDetails?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           
           let urlString =  subscribeURL
           let request = APIRequest(method: .post, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
           var token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
           if token == nil {
               AWSUserSingleton.shared.getUserattributes()
           }
           sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
                                   do {
                                    if  let jsonDict = json[ResponseKeys.data.rawValue]  {
                                        if jsonDict != nil {
                                            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                            let packageDetails = try JSONDecoder().decode(PaymentDetails.self, from: jsonData)
                                            successHandler(packageDetails)
                                        }else {
                                            successHandler(nil)
                                        }
                                          
                                       } else {
                                           successHandler(nil)
                                       }
                                   } catch let error {
                                       errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                                   }
                                   
                   }, errorHandler: { error in
                       errorHandler(error)
                   })
       }
    static func postToOrderId(parameters: [String: Any],header:[String: String],dataParams:Data,
                              successHandler: @escaping (OrderDetails) -> Void,
                              errorHandler: @escaping (APIError) -> Void) {
        
        
        let urlString =  OrderIdURL
        let request = APIRequest(method: .post, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        var token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        if token == nil {
            AWSUserSingleton.shared.getUserattributes()
        }
        sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
            do {
                if  let jsonDict = json[ResponseKeys.data.rawValue] {
                    if jsonDict != nil {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                           let orderDetails = try JSONDecoder().decode(OrderDetails.self, from: jsonData)
                                           successHandler(orderDetails)
                    }else {
                        successHandler(OrderDetails(order_id: 0, payment_id: 0, trainee_id: "", program_id: "", order_status: "", order_purchase_date: "", total_amount: 0, amount_without_tax: 0, payment_type_id: 0, tax_break_up_id: 0, paymentgateway_order_id: "", created_date_time: "", updated_date_time: "",stripe_client_secret:""))
                    }
                   
                } else {
                    successHandler(OrderDetails(order_id: 0, payment_id: 0, trainee_id: "", program_id: "", order_status: "", order_purchase_date: "", total_amount: 0, amount_without_tax: 0, payment_type_id: 0, tax_break_up_id: 0, paymentgateway_order_id: "", created_date_time: "", updated_date_time: "",stripe_client_secret:""))
                }
            } catch let error {
                errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
            }
            
        }, errorHandler: { error in
            errorHandler(error)
        })
    }
    static func SyncPaymentToServer(parameters: [String: Any],header:[String: String],dataParams:Data,
                              successHandler: @escaping () -> Void,
                              errorHandler: @escaping (APIError) -> Void) {
        
        
        let urlString =  syncPaymentId
        let request = APIRequest(method: .post, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        var token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        if token == nil {
            AWSUserSingleton.shared.getUserattributes()
        }
        sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
            do {
                if  let jsonDict = json[ResponseKeys.data.rawValue] {
                    if jsonDict != nil {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                        //  let orderDetails = try JSONDecoder().decode(OrderDetails.self, from: jsonData)
                          successHandler()
                    }else {
                         successHandler()
                    }
                    
                } else {
                    successHandler()
                }
            } catch let error {
                errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
            }
            
        }, errorHandler: { error in
            errorHandler(error)
        })
    }
}
