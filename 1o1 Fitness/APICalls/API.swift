//
//  API.swift

//

import Foundation
import Reachability
import Alamofire


enum HeadersKeys {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
}

/// Various values that go in header requests
enum HeaderValues {
    static let token = "bearer"
    static let json = "application/json"
}

protocol AuthenticationToken : class {
    var authenticatedHeaders: HTTPHeaders { get }
}
/// Protocol defining interactions to/from the backing API
protocol API: class {
    
    /// Provider for authentication necessary for API calls
   // static var authenticationProvider: AuthenticationProviding { get }
}

/// Default implementations for the API layer
extension API {
    
    private static var reachability: Reachability? { ReachabilityService.shared.getReachability() }
    
    
    static func sendAPIRequest<T>(_ request: APIRequest,
                                  successHandler: @escaping (T) -> Void,
                                  errorHandler: @escaping ((APIError) -> Void)) {
        
        
        guard let reachability = reachability, reachability.connection != .unavailable else {
            errorHandler(.offline)
            return
        }
          

        
        Alamofire.request(request.url,
                          method: request.method,
                          parameters: request.parameters,
                          encoding: request.parameterEncoding,
                          headers: request.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                    
                case .success(let value):

                    if let result = value as? T {
                        successHandler(result)
                    }

                case .failure(let error):
                    errorHandler(APIError(response))
                }
        }
    }
    
    static func sendAPIRequest(_ request: APIRequest,
                               successHandler: @escaping () -> Void,
                               errorHandler: @escaping ((APIError) -> Void)) {
        
        
        guard let reachability = reachability, reachability.connection != .unavailable else {
            errorHandler(.offline)
            return
        }
        
        Alamofire.request(request.url,
                          method: request.method,
                          parameters: request.parameters,
                          encoding: request.parameterEncoding,
                          headers: request.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    successHandler()
                case .failure(let error):
               //     Logger.error("API Response Failure with error: \(error)")
                    errorHandler(APIError(response))
                }
        }
    }
    static func sendAPIRequestBody<T>(_ request: APIRequest,token:String,
                               successHandler: @escaping (T) -> Void,
                               errorHandler: @escaping ((APIError) -> Void)) {
        
        
        guard let reachability = reachability, reachability.connection != .unavailable else {
            errorHandler(.offline)
            return
        }
        let urlString = request.url
        guard let url = URL(string: urlString) else {return}
        var dataReq        = URLRequest(url: url)
        dataReq.httpMethod = request.method.rawValue
        dataReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        dataReq.setValue(token, forHTTPHeaderField: "Authorization")
        dataReq.httpBody   =  request.dataParams!
          
        Alamofire.request(dataReq).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                if let result = value as? T {
                    successHandler(result)
                }
                
            case .failure(let error):
                errorHandler(APIError(response))
            }
        }
    }
}
