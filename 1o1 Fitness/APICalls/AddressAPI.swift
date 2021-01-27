//
//  AddressAPI.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 20/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class AddressAPI: API {

    static func postAddress(parameters: [String: Any],header:[String: String],dataParams:Data,methodName: String,
                    successHandler: @escaping ([Address]?) -> Void,
                    errorHandler: @escaping (APIError) -> Void) {
       
       
       let urlString =  addressPostURL + ProgramDetails.programDetails.subId + "/address"
        var request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        switch methodName {
        case "post":
            request = APIRequest(method: .post, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
            case "put":
            request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        default:
            request = APIRequest(method: .put, url: urlString, parameters: parameters, headers: header, dataParams: dataParams)
        }
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
       if token == nil {
           AWSUserSingleton.shared.getUserattributes()
       }
    sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
        do {
            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                if jsonDict != nil {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                    let address = try JSONDecoder().decode([Address].self, from: jsonData)
                    successHandler(address)
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
    static func deleteAddress(addressId: String,header:[String: String],
                     successHandler: @escaping ([Address]?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        

        let urlString =  addressPostURL + ProgramDetails.programDetails.subId + "/address/" + addressId
        let request = APIRequest(method: .delete, url: urlString, parameters: [:], headers: header, dataParams: nil)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        if token == nil {
            AWSUserSingleton.shared.getUserattributes()
        }
        sendAPIRequest(request, successHandler: { (json: JSON) in
            do {
                if  let jsonDict = json[ResponseKeys.data.rawValue] {
                    if jsonDict != nil {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                        let address = try JSONDecoder().decode([Address].self, from: jsonData)
                        successHandler(address)
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

//     sendAPIRequestBody(request, token: "\(HeaderValues.token) \(token!) ", successHandler: { (json: JSON) in
//         do {
//             if  let jsonDict = json[ResponseKeys.data.rawValue] {
//                 if jsonDict != nil {
//                     let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
//                     let address = try JSONDecoder().decode([Address].self, from: jsonData)
//                     successHandler(address)
//                 }else {
//                     successHandler(nil)
//                 }
//             } else {
//                   successHandler(nil)
//               }
//         } catch let error {
//             errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
//         }
//
//     }, errorHandler: { error in
//                    errorHandler(error)
//                })
//    }
    static func getAddress(header:[String: String],
                     successHandler: @escaping ([Address]?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        
        let urlString =  addressPostURL + ProgramDetails.programDetails.subId + "/address"
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
                        let address = try JSONDecoder().decode([Address].self, from: jsonData)
                        successHandler(address)
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
}

