//
//  TrainerSearch.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 03/11/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class TrainerSearch: API
{
    static func searchTrainers(searchText: String,header:[String: String],
                        successHandler: @escaping ([TrainerInfo]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           let urlString =  String(format: "%@%@", trainersSearch,searchText)
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
                                    let trainerInfo = try JSONDecoder().decode([TrainerInfo].self, from: jsonData)
                                    successHandler(trainerInfo)
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
}
