//
//  YogaAPI.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 30/06/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit

final class YogaAPI: API {
    static func post(traineeId: String,programId: String,header:[String: String],date: String,
                     successHandler: @escaping (YogaModel?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        messageString = ""
        
        var fitness = "Fitness"
       
        if let fitnessType = UserDefaults.standard.string(forKey: "FitnessType") {
            fitness = fitnessType
        }
       // ?trainee_id=37aa26f0-14a4-40e5-ba78-a6825c36d3e5&program_id=5ec8cbcb71038065bb3dc8a2
        let urlString = getCalenderforDay + "trainee_id=" + traineeId  + "&date=" + date + "&category=" + fitness
        //let request = APIRequest((method: .post, url: urlString, parameters: parameters, headers: header, data))
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    let yogaModel = try JSONDecoder().decode(YogaModel.self, from: jsonData)
                                    successHandler(yogaModel)
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
