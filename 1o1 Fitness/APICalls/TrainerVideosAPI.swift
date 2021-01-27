//
//  TrainerVideosAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 22/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

final class TrainerVideosAPI: API
{
    static func post(trainerId: String,header:[String: String],
                     successHandler: @escaping ([TrainerVideoList]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        
        let urlString =  getTrainerProfile + trainerId + "/exercises/public"
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                                                   let videoList = try JSONDecoder().decode([TrainerVideoList].self, from: jsonData)
                                                                   successHandler(videoList)
                                }else {
                                    successHandler([])
                                }
                               
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


