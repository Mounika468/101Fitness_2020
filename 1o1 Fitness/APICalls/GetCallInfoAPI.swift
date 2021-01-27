//
//  GetCallInfoAPI.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 11/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
//var messageString = ""

final class GetCallInfoByDateAPI: API
{
    static func postToSchedule(header:[String: String],dataParams:Data,
                     successHandler: @escaping ([SchedulesData]?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        let urlString = getAllCallForTrainee
        let request = APIRequest(method: .post, url: urlString, parameters: [:], headers: header, dataParams: dataParams)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                    let schedules = try JSONDecoder().decode([SchedulesData].self, from: jsonData)
                                    successHandler(schedules)
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
    static func postToSlot(header:[String: String],dataParams:Data,
                     successHandler: @escaping (DayWorkOuts) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        
        let urlString = bookSlotForCall
        let request = APIRequest(method: .post, url: urlString, parameters: [:], headers: header, dataParams: dataParams)

        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
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
    static func checkRoomStatus(header:[String: String],slotId:String,schedulerId:String,traineeid:String,
                       successHandler: @escaping (TwilioToken?) -> Void,
                       errorHandler: @escaping (APIError) -> Void) {
                           messageString = ""
                           let urlString = bookSlotForCall + "/\(traineeid)" + "?slotId=" + slotId
                           let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

                           sendAPIRequest(request,
                                          successHandler: { (json: JSON) in
                                           do {
                                               if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                                   if jsonDict != nil {
                                                       let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                                       let token = try JSONDecoder().decode(TwilioToken.self, from: jsonData)
                                                       successHandler(token)
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
    
    static func getTokenForCall(header:[String: String],roomName:String,traineeid:String,
    successHandler: @escaping (TwilioToken?) -> Void,
    errorHandler: @escaping (APIError) -> Void) {
        
        let urlString = getToken + "roomName=" + roomName + "&name=" + traineeid
        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)
        messageString = ""
        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                           
                            if json != nil && json.count > 0 {
                                    let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
                                    let token = try JSONDecoder().decode(TwilioToken.self, from: jsonData)
                                    successHandler(token)
                            }else {
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
