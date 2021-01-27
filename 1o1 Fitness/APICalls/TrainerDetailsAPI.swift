//
//  TrainerDetailsAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 21/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

final class TrainerDetailsAPI: API
{
    static func post(trainerId: String,header:[String: String],
                     successHandler: @escaping ([TrainerProfile]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        
        let urlString =  getTrainerProfile + trainerId + "?details=partial"
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                let trainerProfile = try JSONDecoder().decode([TrainerProfile].self, from: jsonData)
                                successHandler(trainerProfile)
                            } else {
                                successHandler([])
                            }
                        } catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
}

