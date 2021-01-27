//
//  ContactsAPI.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 04/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation

final class ContactsAPI: API
{
    static func getContactUsSections(header:[String: String],
                        successHandler: @escaping (ContactusResponse?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           let urlString =  getcontactUs
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
                                    let contactUs = try JSONDecoder().decode(ContactusResponse.self, from: jsonData)
                                    successHandler(contactUs)
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
    static func postContactUsInfo(header:[String: String],dataParams:Data,
                        successHandler: @escaping (String) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {

           let urlString =  postContactComments
           let request = APIRequest(method: .post, url: urlString, parameters: nil, headers: header, dataParams: dataParams)
        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                   // let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    //let photos = try JSONDecoder().decode(urlString.self, from: jsonData)
                                    successHandler("")
                                }else {
                                    if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                        messageString = (jsonMessage as? String)!
                                        successHandler(messageString)
                                    }
                                }
                                
                            } else {
                                
                                  successHandler("")
                            }
                        }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }

        }, errorHandler: { error in
            errorHandler(error)
        })
       }
}
