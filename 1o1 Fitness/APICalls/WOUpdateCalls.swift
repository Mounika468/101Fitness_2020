//
//  WOUpdateCalls.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 01/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

final class WOUpdateCalls: API {
    
    static func setsUpdatePost(parameters: [String: Any],header:[String: String],dataParams:Data,
                        successHandler: @escaping (DayWorkOuts) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           
           let urlString =  woSetsUpdate
           let request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
           var token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
           if token == nil {
               AWSUserSingleton.shared.getUserattributes()
           }
        sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
            do {
                if  let jsonDict = json[ResponseKeys.data.rawValue] {
                    if jsonDict != nil {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                        let workouts = try JSONDecoder().decode(DayWorkOuts.self, from: jsonData)
                        successHandler(workouts)
                    }else {
                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                            messageString = (jsonMessage as? String)!
                            successHandler(DayWorkOuts(day: 0, rest: false))
                        }
                    }
                   
                } else {
                    successHandler(DayWorkOuts(day: 0, rest: false))
                }
            } catch let error {
                errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
            }
            
        }, errorHandler: { error in
                       errorHandler(error)
                   })
       }

}
