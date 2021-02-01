//
//  RefundsAPI.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 27/01/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import Alamofire
final class RefundsAPI: API
{
    static func postRefundCall(comments:String,programId: String,reason:String,
                        successHandler: @escaping () -> Void,
                        errorHandler: @escaping (String) -> Void) {
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        let refundDate = Date.getCurrentDateInFormat(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        let deviceModel = UIDevice.current.model
        

        let traineeId = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) ?? ""
        
        let postBody : [String: Any] = ["comments": comments,"os_version":"IOS","app_version": "1.08","devise_model": deviceModel,"currentDateTime": refundDate,"raisedBy": traineeId, "status":"new","program_id" : programId,"requestType" :"Refund","refund_reason": reason]
        
        let urlString = postRefundURL
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
//                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
//                                                                                  options: .prettyPrinted)
//                                        let trainerInfo = try JSONDecoder().decode([TrainerInfo].self, from: jsonData)
                                        successHandler()
                                    }else {
                                       successHandler()
                                    }
                                    
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                    successHandler()
                                }
                                successHandler()
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
