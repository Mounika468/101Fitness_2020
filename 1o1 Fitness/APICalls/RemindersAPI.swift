//
//  RemindersAPI.swift
//  1o1 Fitness
//
//  Created by Hareen.Pulivarthi on 21/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

final class RemindersAPI: API
{
    static func getRemindersCall(header:[String: String],
                        successHandler: @escaping (Reminders?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
        
        let urlString =  String(format: "%@%@", getReminders,UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!)
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)
     sendAPIRequest(request,
                    successHandler: { (json: JSON) in
                     do {
                          if json[ResponseKeys.data.rawValue] != nil
                          {
                         if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                             if jsonDict != nil {
                                 let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                           options: .prettyPrinted)
                                 let remiders = try JSONDecoder().decode(Reminders.self, from: jsonData)
                                 successHandler(remiders)
                             }else {
                                successHandler(nil)
                             }
                             
                         } else {
                             successHandler(nil)
                         }
                     } }catch let error {
                         errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                     }
                     
     }, errorHandler: { error in
         errorHandler(error)
     })
    }
    static func postRemindersInfo(header:[String: String],dataParams:Data,
                        successHandler: @escaping (Reminders?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {

           let urlString =  postReminders
           let request = APIRequest(method: .put, url: urlString, parameters: nil, headers: header, dataParams: dataParams)
        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                              options: .prettyPrinted)
                                    let remiders = try JSONDecoder().decode(Reminders.self, from: jsonData)
                                    successHandler(remiders)
                                }else {
                                   successHandler(nil)
                                }
                                
                            } else {
                                
                                  successHandler(nil)
                            }
                        }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }

        }, errorHandler: { error in
            errorHandler(error)
        })
       }
}

struct Token {
    static var fcmToken:String? = nil

    static func setToken(fcmToken:String) {
        Token.fcmToken = fcmToken
    }
}
