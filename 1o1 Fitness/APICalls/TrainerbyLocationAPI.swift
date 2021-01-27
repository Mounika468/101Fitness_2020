//
//  TrainerbyLocationAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 07/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import Alamofire

final class TrainerbyLocationAPI: API
{
    static func post(parameters: Dictionary<String, Any>,header:[String: String],
                     successHandler: @escaping ([TrainerInfo]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        let longitude = parameters["longitude"] as! String
        let latitude = parameters["latitude"] as! String
        let urlString =  getTrainerByLocation + "longitude=" + longitude + "&latitude=" + latitude + "&details=partial"
        let parameters = parameters as [String: Any]
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
                                   successHandler([])
                                }
                                
                            } else {
                                successHandler([])
                            }
                        } }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
    static func postCalltoToken(parameters: Dictionary<String, Any>,details:String,pageNumber: Int,
                                successHandler: @escaping ([TrainerInfo]) -> Void,
                                errorHandler: @escaping (String) -> Void) {
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        let userdefaults = UserDefaults.standard
        var fcmtoken = Token.fcmToken ?? ""
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin  {
                fcmtoken = ""
            }
        }
        
        let traineeId = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) ?? ""
        let longitude = parameters["longitude"] as! String
        let latitude = parameters["latitude"] as! String
        let postBody : [String: Any] = ["longitude": longitude,"latitude":latitude,"details": details,"trainee_id": traineeId,"pagesize": 12,"pagenumber": pageNumber, "registration_token":fcmtoken]

        let urlString = getTrainerByLocation
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
                            if json["code"] as? Int != 20
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict != nil {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let trainerInfo = try JSONDecoder().decode([TrainerInfo].self, from: jsonData)
                                        successHandler(trainerInfo)
                                    }else {
                                       successHandler([])
                                    }
                                    
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                    successHandler([])
                                }
                                successHandler([])
                            }
                        }catch let error {
                            errorHandler(error.localizedDescription)
                        }
                    }
 
                default:
                    errorHandler("Fetching details failed")

                }
            }
        }
    }
}
final class GetTrainersAPI: API
{
    static func post(parameters: Dictionary<String, Any>,pageNumber:Int,header:[String: String],
                     successHandler: @escaping ([TrainerInfo]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        let urlString =  String(format:"%@?pagenumber=%d&pagesize=16",getAllTrainers,pageNumber)
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
                                    successHandler([])
                                }
                               
                            } else {
                                successHandler([])
                            }
                        } }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
}
final class GetLocationsAPI: API
{
    static func getCountries(header:[String: String],
                     successHandler: @escaping ([CountriesInfo]?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        let urlString =  getCountriesList
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
                                                                   let countries = try JSONDecoder().decode([CountriesInfo].self, from: jsonData)
                                                                   successHandler(countries)
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
    static func getStates(countriesID:String ,header:[String: String],
                        successHandler: @escaping ([StatesInfo]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           let urlString =  getCountriesList + "/" + countriesID + "/states"
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
                                                                      let states = try JSONDecoder().decode([StatesInfo].self, from: jsonData)
                                                                      successHandler(states)
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
