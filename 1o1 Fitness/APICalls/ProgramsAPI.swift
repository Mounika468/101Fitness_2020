//
//  ProgramsAPI.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class ProgramAPI: API
{
    static func getOrdersAPI(traineeId: String,header:[String: String],
                        successHandler: @escaping ([MyOrders]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           let urlString =  String(format: "%@%@/orders", getPrograms,traineeId)
           let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)
           let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
           if token == nil {
               AWSUserSingleton.shared.getUserattributes()
           }
           sendAPIRequest(request, successHandler: { (json: JSON) in
               do {
                   if  let jsonDict = json[ResponseKeys.data.rawValue] {
                       if jsonDict != nil {
                           let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                           let programs = try JSONDecoder().decode([MyOrders].self, from: jsonData)
                           successHandler(programs)
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
  
    static func getProgramsAPI(traineeId: String,header:[String: String],
                        successHandler: @escaping ([MyPrograms]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           let urlString =  String(format: "%@%@/myprograms", getPrograms,traineeId)
           let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)
           let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
           if token == nil {
               AWSUserSingleton.shared.getUserattributes()
           }
           sendAPIRequest(request, successHandler: { (json: JSON) in
               do {
                   if  let jsonDict = json[ResponseKeys.data.rawValue] {
                       if jsonDict != nil {
                           let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                           let programs = try JSONDecoder().decode([MyPrograms].self, from: jsonData)
                           successHandler(programs)
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
    static func getDetailsForProgram(header:[String: String],traineeId:String,orderId:String,
                         successHandler: @escaping (MyProgramsDetails?) -> Void,
                         errorHandler: @escaping (APIError) -> Void) {
                             
        let urlString =  String(format: "%@%@/orders/%@", getDetailsForProgramId,traineeId,orderId)
                             let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

                             sendAPIRequest(request,
                                            successHandler: { (json: JSON) in
                                             do {
                                                 if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                                     if jsonDict != nil {
                                                         let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                                         let details = try JSONDecoder().decode(MyProgramsDetails.self, from: jsonData)
                                                         successHandler(details)
                                                     }else {
                                                         if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                                             messageString = (jsonMessage as? String)!
                                                             successHandler(nil)
                                                         }
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
    static func getOrderSuccessDetails(header:[String: String],traineeId:String,orderId:String,
                         successHandler: @escaping (MyProgramsDetails?) -> Void,
                         errorHandler: @escaping (APIError) -> Void) {
                             
        let urlString =  String(format: "%@%@/orders/%@", getDetailsForProgramId,traineeId,orderId)
                             let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

                             sendAPIRequest(request,
                                            successHandler: { (json: JSON) in
                                             do {
                                                 if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                                     if jsonDict != nil {
                                                         let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                                         let details = try JSONDecoder().decode(MyProgramsDetails.self, from: jsonData)
                                                         successHandler(details)
                                                     }else {
                                                         if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                                             messageString = (jsonMessage as? String)!
                                                             successHandler(nil)
                                                         }
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
}
