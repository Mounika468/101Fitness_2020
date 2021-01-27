//
//  GetExerciseInfoAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 04/02/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class GetExerciseInfoAPI: API
{
//    static func post(exerciseId: String,header:[String: String],
//                     successHandler: @escaping ([ExerciseInfo]) -> Void,
//                     errorHandler: @escaping (APIError) -> Void) {
//
//
//        let urlString = baseHostURL + getExerciseList + exerciseId
//        let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)
//
//        sendAPIRequest(request,
//                       successHandler: { (json: JSON) in
//                        do {
//                            if  let jsonDict = json[ResponseKeys.data.rawValue] {
//                                let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any, options: .prettyPrinted)
//                                let exeInfo = try JSONDecoder().decode([ExerciseInfo].self, from: jsonData)
//                                successHandler(exeInfo)
//                            } else {
//                                successHandler([])
//                            }
//                        } catch let error {
//                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
//                        }
//
//        }, errorHandler: { error in
//            errorHandler(error)
//        })
//
//    }
}
