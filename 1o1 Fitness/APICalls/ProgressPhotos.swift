//
//  ProgressPhotos.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 22/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class ProgressPhotosByDateAPI: API
{
  
    static func deletePhotoAPI(traineeId: String,photoId: String,header:[String: String],
                        successHandler: @escaping ([ProgressPhoto]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           let urlString =  deletePhoto + traineeId + "/progressphotos/" + photoId
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
                           let photos = try JSONDecoder().decode([ProgressPhoto].self, from: jsonData)
                           successHandler(photos)
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
    static func getAllPhotosAPI(header:[String: String],traineeId:String,
                         successHandler: @escaping ([ProgressPhoto]?) -> Void,
                         errorHandler: @escaping (APIError) -> Void) {
                             
                             let urlString = getAllPhotos +  traineeId + "/progressphotos"
                             let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)

                             sendAPIRequest(request,
                                            successHandler: { (json: JSON) in
                                             do {
                                                 if  let jsonDict = json[ResponseKeys.data.rawValue] {
                                                     if jsonDict != nil {
                                                         let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
                                                         let photos = try JSONDecoder().decode([ProgressPhoto].self, from: jsonData)
                                                         successHandler(photos)
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
}
