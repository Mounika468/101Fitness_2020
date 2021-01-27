//
//  TrainerPackageAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 21/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation


final class TrainerPackageAPI: API
{
    static func post(trainerId: String,header:[String: String],
                     successHandler: @escaping (TrainerPackage?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        

        
        let urlString = getTrainerPackage + trainerId + "/programs?packageType=All"
       // let parameters = parameters as [String: Any]
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header,dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                                             options: .prettyPrinted)
                                                                   let package = try JSONDecoder().decode(TrainerPackage.self, from: jsonData)
                                                                   successHandler(package)
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
    static func postToDetails(trainerId: String,programId: String,header:[String: String],
                     successHandler: @escaping ([PackageDetails]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
       
       let urlString = String(format: "%@%@/programs/%@?trainee_id=%@", getTrainerPackage,trainerId,programId,UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!)
        
      //  let urlString = getTrainerPackage + trainerId + "/programs/" + programId
       // let parameters = parameters as [String: Any]
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                              options: .prettyPrinted)
                                    let package = try JSONDecoder().decode([PackageDetails].self, from: jsonData)
                                    successHandler(package)
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

