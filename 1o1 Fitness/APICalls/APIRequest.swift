

import Foundation
import Alamofire

/// Struct to hold an API request
struct APIRequest {
    /// Request method
    let method: HTTPMethod
    /// URL for the request
    let url: String
    /// Request parameters
    let parameters: [String: Any]?
    /// Encoding to use for the request's parameters. Default is JSONEncoding
    var parameterEncoding: ParameterEncoding = JSONEncoding.default
    /// Request headers
    let headers: HTTPHeaders
    
    let dataParams :  Data?
    // let parametersString: String?
}

/// Common keys that are in API responses
enum ResponseKeys: String {
    /// The data returned in the response
    case data
    /// The content returned in the response
    case message
}

// MARK: API Specific Type Aliases

typealias JSON = [String: Any?]
typealias JSONArray = [Any?]
typealias JSONString = String
typealias HTTPHeaders = [String: String]

typealias APIParameter = String
extension APIParameter {
    enum Keys {
        static let error = "error"
        static let errors = "errors"
        static let detail = "detail"
    }
}
