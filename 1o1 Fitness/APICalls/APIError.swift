

import Foundation
import Alamofire

/// Enum for API Errors
enum APIError: Error {
    
    /// Bad Request (message)
    case badRequest(ErrorMessage)
    /// Server Error (message)
    case server(ErrorMessage)
    /// Unauthorized (message)
    case unauthorized(ErrorMessage)
    /// Invalid Reponse (message)
    case invalidResponse(ErrorMessage)
    /// 404 Not Found (message)
    case notFound(ErrorMessage)
    /// User offline (message)
    case offline
    /// Unknown error (message)
    case unknown(String)
    
    init(_ response: DataResponse<Any>) {
        
        guard let statusCode = response.response?.statusCode else {
            self = .unknown("")
            return
        }
        
        let errorMessage = APIError.getErrorMessage(response)
        switch statusCode {
        case 400: // Bad Request
            self = .badRequest(errorMessage)
        case 401: // Unauthorized
            self = .unauthorized(errorMessage)
        case 404: // Not Found
            self = .notFound(errorMessage)
        default: // Default to Server
            self = .server(errorMessage)
        }
    }
    
    /**
     Parses the error message from the data response and returns in
     
     - parameter response: The response returned from the server
     
     - returns: String of the error code and message. Defaults to general error message
     */
    static func getErrorMessage(_ response: DataResponse<Any>) -> ErrorMessage {
        
        guard let data = response.data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let errors = json[APIParameter.Keys.errors] as? [[String: Any]]
            else { return ErrorMessage("error")
             // return "Unknown error"
        }
        
        let errorList = errors.compactMap {
            ($0[APIParameter.Keys.error] as? [String: String])?[APIParameter.Keys.detail]
        }
        
        return ErrorMessage(errorList)
    }
}

/// API Error Localized Error Messages
extension APIError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .badRequest(let errorMessage):
            return errorMessage.localizedDescription
        case .server(let errorMessage):
            return errorMessage.localizedDescription
        case .unauthorized(let errorMessage):
            return errorMessage.localizedDescription
        case .invalidResponse(let errorMessage):
            return errorMessage.localizedDescription
        case .notFound(let errorMessage):
            return errorMessage.localizedDescription
        case .unknown(let string):
            return string
        case .offline:
            return "Offline"
           // return R.string.localizable.offline()
        }
    }
}

/// Struct containing the error message(s) to display to the user
struct ErrorMessage {
    
    /// The type of the error message (single message, or multiple)
    let type: ErrorMessageType
    /// The data of the error message
    let data: Any
    
    /**
     Initialize the error message with the given data
     
     - parameter data: The data of the error message.
     A String passed in here is considered a 'single' error message,
     and any other type is considered to be a 'multiple' error message.
     */
    init(_ data: Any) {
        
        self.data = data
        self.type = data is String ||
            (data as? [Any])?.count == 1 ? .single : .multi
    }
    
    /// The localized description of the error message. Used to display to the user.
    var localizedDescription: String {
        
        switch data {
        case let data as String: // A simple string error message, possibly from iOS
            return data
        case let data as [String]: // A container holding strings
            if data.count == 1 {
               // return data.first ?? R.string.localizable.errorUnknown()
                 return data.first ?? "Unknown error"
            } else if data.count > 1 {
                return data.joined(separator: "\n")
            } else {
                //return R.string.localizable.errorUnknown()
                return "Unknown error"
            }
        default:
           // return R.string.localizable.errorUnknown()
             return "Unknown error"
        }
    }
}

/// Enum defining the error message type
enum ErrorMessageType {
    
    /// indicates a single error message
    case single
    /// indicates multiple error messages
    case multi
}
