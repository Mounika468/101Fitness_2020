//
//  TraineeRegister.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 26/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import Alamofire
final class TraineeRegister: API
{
    static func postBasicTraieeDetails(userType:String,successHandler: @escaping (String) -> Void, errorHandler: @escaping (String) -> Void){
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        let traineeId = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!
        let postBody : [String: Any] = ["first_name": TraineeInfo.details.first_name,"trainee_id":traineeId,"email": TraineeInfo.details.email,"trainee_profile_staus": userType,"username": TraineeInfo.details.username,"address_submission": false, "profile_submission":false, "user_type":"trial", "created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"last_name": TraineeInfo.details.last_name,"mobile_no": TraineeInfo.details.mobile_no,"country_code":TraineeInfo.details.country_code]

        let urlString = postTraineeDetails
        guard let url = URL(string: urlString) else {return}
        var request        = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        Alamofire.request(request).responseJSON{ (response) in
            
            print("response is \(response)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        do {
                            if json["code"] as? Int != 30
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    successHandler("")
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                    successHandler(messageString)
                                }
                                successHandler("")
                            }
                        }catch let error {
                            successHandler(error.localizedDescription)
                        }
                    }
 
                default:
                    errorHandler("User registration failure")

                }
            }
        }
    }
    static func post(parameters: [String: Any],header:[String: String],
                     successHandler: @escaping () -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        
        let urlString = postTraineeDetails
        let request = APIRequest(method: .post, url: urlString, parameters:parameters, headers: header, dataParams: nil)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    //                                let calenderEvents = try JSONDecoder().decode([TraineeCalender].self, from: jsonData)
                                                                    successHandler()
                                }else {
                                     successHandler()
                                }
                                
                            } else {
                                successHandler()
                            }
                        } catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
    static func postBasic(parameters: [String: Any],header:[String: String] ,dataParams:Data,
                         successHandler: @escaping () -> Void,
                         errorHandler: @escaping (APIError) -> Void) {
            
            
            let urlString = postTraineeDetails
        let request = APIRequest(method: .post, url: urlString, parameters:parameters, headers: header, dataParams: dataParams)

            sendAPIRequest(request,
                           successHandler: { (json: JSON) in
                            do {
                                    successHandler()
                                
                            } catch let error {
                                errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                            }
                            
            }, errorHandler: { error in
                errorHandler(error)
            })

        }
        
    static func getTraineeDetails(traineeId:String,header:[String: String],
                        successHandler: @escaping (TraineeDetails?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
          
           let urlString = postTraineeDetails + "/" + traineeId
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
                                    let traineeDetails = try JSONDecoder().decode(TraineeDetails.self, from: jsonData)
                                    successHandler(traineeDetails)
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
    static func postTraineeImage(traineeId:String,header:[String: String],
                        successHandler: @escaping (TraineeDetails?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
          
           let urlString = postTraineeDetails + "/" + traineeId
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
                                    let traineeDetails = try JSONDecoder().decode(TraineeDetails.self, from: jsonData)
                                    successHandler(traineeDetails)
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

