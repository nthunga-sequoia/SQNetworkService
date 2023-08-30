//
//  NetworkManager.swift
//  Sequoia
//
//  Copyright © 2016 YMediaLabs. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

typealias Helper = NetworkManager

class NetworkManager {
    static var baseUrlString: String = ""
    static var removeKeysWithNullValues: Bool = true //Default value is true.
    static let reachability: NetworkReachabilityManager? = NetworkReachabilityManager()
    static var responseInSwiftyJSon: Bool = false //Default value is false.
    static var debugLog: Bool = true //Default value is true.
    static var headers: [String: String]?
    
    struct MultiPartData {
        var multipartImageDataKey: String!
        var multipartTextDataKey: String!
        var multipartImageFileUrl: [String]!
        var multipartMaxFileSize: Double!
        var multipartTextJson: [String: Any]!
    }
    
    ///  Enum which confirms to alamofire protocol URLRequestConvertible to form a NSMutableRequest based network request type.
    enum Request: URLRequestConvertible {
        /// match URLRequest routes to Alamofire methods
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?, method: Alamofire.HTTPMethod, encoding: Alamofire.ParameterEncoding) = {
                switch self {
                case .get(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.get, encoding: URLEncoding.default)
                case .post(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.post, encoding: JSONEncoding.default)
                case .postUrlEncoded(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.post, encoding: URLEncoding.default)
                case .put(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.put, encoding: JSONEncoding.default)
                case .patch(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.patch, encoding: JSONEncoding.default)
                case .delete(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.delete, encoding: URLEncoding.default)
                case .deleteJsonEncoded(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.delete, encoding: JSONEncoding.default)
                case .upload(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.post, encoding: JSONEncoding.default)
                case .putUpload(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.put, encoding: JSONEncoding.default)
                }
            }()
            
            /// Generate URL Request
            var request: URLRequest!
            
            if let requestUrl = URL(string: result.path) {
                request = URLRequest(url: requestUrl)
            }
            
//            if let baseUrlString = baseUrlString {
//                if let requestUrl = URL(string: baseUrlString)?.appendingPathComponent(result.path) {
//                    request = URLRequest(url: requestUrl)
//                    
//                }
//            }
            
            request.timeoutInterval = result.timeoutInterval
            request.httpMethod = result.method.rawValue
            
            /// Create URLRequest inclunding the encoded parameters
            let encoding = result.encoding
            var encodedRequest: URLRequest = request
            
            do {
                encodedRequest = try encoding.encode(request, with: result.parameters)
            } catch {
            }
            
            encodedRequest.httpMethod = result.method.rawValue
            
            if let headers = headers {
                for headerKey in headers.keys {
                    if let headerValue = headers[headerKey] {
                        encodedRequest.addValue(headerValue, forHTTPHeaderField: headerKey)
                    }
                }
            }
            return encodedRequest
        }
        
        case get(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case post(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case postUrlEncoded(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case put(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case patch(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case delete(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case upload(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case putUpload(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
        case deleteJsonEncoded(path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?)
                
        var requestParamters: [String: Any]? {
            let result: (path: String, timeoutInterval: TimeInterval, parameters: [String: Any]?, method: Alamofire.HTTPMethod, encoding: Alamofire.ParameterEncoding) = {
                switch self {
                case .get(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.get, encoding: URLEncoding.default)
                case .post(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.post, encoding: JSONEncoding.default)
                case .postUrlEncoded(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.post, encoding: URLEncoding.default)
                case .put(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.put, encoding: JSONEncoding.default)
                case .patch(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.patch, encoding: JSONEncoding.default)
                case .delete(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.delete, encoding: URLEncoding.default)
                case .upload(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.post, encoding: JSONEncoding.default)
                case .putUpload(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.put, encoding: JSONEncoding.default)
                case .deleteJsonEncoded(let path, let timeoutInterval, let parameters):
                    return (path: path, timeoutInterval: timeoutInterval, parameters: parameters, method: HTTPMethod.delete, encoding: JSONEncoding.default)
                }
            }()
            return result.parameters
        }
    }
    
    /// This method cancel all current api calls by invalidating the curren session.
    static func cancelAllRequests() {        
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
    
    ///  This method will send request by using Alamofire with particular URLRequestConvertible implemented Object.
    /// - parameter request: It's a mutable request object which confirms to URLRequestConvertible protocol.
    /// - parameter headers: Any custom http headers for the request, which defaults to nil
    /// - parameter success: A closure to be executed once the request has been succesfully finished.
    /// - parameter failure: A closure to be executed once the request has been finished with failure reason.
    
    static func sendRequest(_ request: Request, headers: [String: String]? = nil,
                            success: @escaping ((_ request: URLRequest?, _ response: AnyObject?) -> Void), failure: @escaping ((_ request: URLRequest?, _ error: NSError) -> Void)) -> DataRequest? {
        if reachability?.isReachable == true {
            NetworkManager.headers = headers
            if debugLog == true {
                #if DEBUG || DEV || TESTSERVER
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Api Request: \(String(describing: request.urlRequest)) \n Request Method: \(request.urlRequest?.httpMethod ?? "") \n Headers: \(request.urlRequest?.allHTTPHeaderFields ?? [:]) \n TimeOutInterval: \(String(describing: request.urlRequest?.timeoutInterval))")
                #endif
            }
            let dataRequest = AF.request(request).responseJSON(completionHandler: { (dataResponse) in
                handleTheResponse(dataResponse, requestObject: request, success: success, failure: failure)
            })
            return dataRequest
        } else {
            failure(request.urlRequest, networkError())
            return nil
        }
    }
    
    ///  This method will send request by using Alamofire with particular URLRequestConvertible implemented Object.
    /// - parameter request: It's a mutable request object which confirms to URLRequestConvertible protocol.
    /// - parameter headers: Any custom http headers for the request, which defaults to nil
    /// - parameter success: A closure to be executed once the request has been succesfully finished.
    /// - parameter failure: A closure to be executed once the request has been finished with failure reason.
    
    static func sendDataRequest(_ request: Request, headers: [String: String]? = nil,
                            success: @escaping ((_ request: URLRequest?, _ response: AnyObject?) -> Void), failure: @escaping ((_ request: URLRequest?, _ error: NSError) -> Void)) -> DataRequest? {
        if reachability?.isReachable == true {
            NetworkManager.headers = headers
            if debugLog == true {
                #if DEBUG || DEV || TESTSERVER
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Api Request: \(String(describing: request.urlRequest)) \n Request Method: \(request.urlRequest?.httpMethod ?? "") \n Headers: \(request.urlRequest?.allHTTPHeaderFields ?? [:]) \n TimeOutInterval: \(String(describing: request.urlRequest?.timeoutInterval))")
                #endif
            }
            let dataRequest = AF.request(request).responseData { responseData in
                if let data = responseData.data {
                    success(nil, data as AnyObject)
                } else {
                    failure(nil, customUnknownError())
                }
            }
            return dataRequest
        } else {
            failure(request.urlRequest, networkError())
            return nil
        }
    }
    
    ///  This method will send direct Urlrequest by using Alamofire with particular URLRequestConvertible implemented Object.
    /// - parameter request: It's a mutable request object which confirms to URLRequestConvertible protocol.
    /// - parameter headers: Any custom http headers for the request, which defaults to nil
    /// - parameter success: A closure to be executed once the request has been succesfully finished.
    /// - parameter failure: A closure to be executed once the request has been finished with failure reason.
    static func sendMutableRequest(_ request: URLRequest, headers: [String: String]? = nil, success: @escaping ((_ request: URLRequest?, _ response: AnyObject?) -> Void), failure: @escaping ((_ request: URLRequest?, _ error: NSError) -> Void)) {
        let aRequest = try? request.asURLRequest()
        if reachability?.isReachable == true {
            NetworkManager.headers = headers
            if debugLog == true {
                #if DEBUG || DEV || TESTSERVER
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Api Request: \(String(describing: aRequest)) \n Request Method: \(aRequest?.httpMethod ?? "") \n Headers: \(aRequest?.allHTTPHeaderFields ?? [:]) \n TimeOutInterval: \(String(describing: aRequest?.timeoutInterval))")
                #endif
            }
            AF.request(request).responseJSON(completionHandler: { (dataResponse) in
                handleTheResponse(dataResponse, requestObject: nil, success: success, failure: failure)
            })
        } else {
            failure(aRequest, networkError())
        }
    }
    
    ///  This method will send upload request by using Alamofire with particular URLRequestConvertible implemented Object and fileurlstring with key.
    /// - parameter request: It's a mutable request object which confirms to URLRequestConvertible protocol.
    /// - parameter multipartData: A structure which has the json data and list of image urls to upload the iamges.
    /// - parameter fileUrlString: File filepathurl string. Note: This should be for sure File path URl string.
    /// - parameter headers: Any custom http headers for the request, which defaults to nil
    /// - parameter success: A closure to be executed once the request has been succesfully finished.
    /// - parameter failure: A closure to be executed once the request has been finished with failure reason.
    static func postFormDataRequest(_ request: Request, multipartData: MultiPartData, headers: [String: String]? = nil, success: @escaping ((_ request: URLRequest?, _ response: AnyObject?) -> Void), failure: @escaping ((_ request: URLRequest?, _ error: NSError) -> Void)) {
        if reachability?.isReachable == true {
            NetworkManager.headers = headers
            if debugLog == true {
                #if DEBUG || DEV || TESTSERVER
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Api Request: \(String(describing: request.urlRequest)) \n Request Method: \(request.urlRequest?.httpMethod ?? "") \n Headers: \(request.urlRequest?.allHTTPHeaderFields ?? [:]) \n TimeOutInterval: \(String(describing: request.urlRequest?.timeoutInterval))")
                #endif
            }
            AF.upload(multipartFormData: { (multipartFormData) in
                if let fileUrlStrings = multipartData.multipartImageFileUrl {
                    for fileUrlString in fileUrlStrings {
                        let imageDataKey = multipartData.multipartImageDataKey ?? "image"
                        let pathName = URL(fileURLWithPath: fileUrlString).lastPathComponent
                        
                        //As we need to different the content type and perform size reduction for iamges, we used below condition.
                        if let image = UIImage(contentsOfFile: fileUrlString) {
                            if let data = image.jpegData(compressionQuality: 1.0) {
                                let kiloBytes = data.count / 1024
                                let megaBytes = Double(kiloBytes / 1024)
                                var percentage = 1.0
                                if megaBytes > multipartData.multipartMaxFileSize && multipartData.multipartMaxFileSize > 0 {
                                    percentage = multipartData.multipartMaxFileSize / megaBytes
                                }
                                
                                percentage = percentage > 1.0 ? 1.0: percentage
                                percentage = percentage < 0.1 ? 0.1: percentage
                                
                                if let reducedData = image.jpegData(compressionQuality: CGFloat(percentage)) {
                                    multipartFormData.append(reducedData, withName: imageDataKey, fileName: pathName, mimeType: "image/jpeg")
                                    
                                }
                            }
                            
                        } else {
                            do {
                                let fileUrl = URL(fileURLWithPath: fileUrlString)
                                let rawData = try Data(contentsOf: fileUrl)
                                multipartFormData.append(rawData, withName: imageDataKey, fileName: pathName, mimeType: "application/octet-stream")
                            } catch _ as NSError {
                                
                            }
                        }
                    }
                }
                
                if let jsonDict = multipartData.multipartTextJson {
                    for (aKey, aValue) in jsonDict {
                        if let val = (aValue as? String)?.data(using: String.Encoding.utf8) {
                            multipartFormData.append(val, withName: aKey)
                        }
                    }
                }
            }, with: request).responseJSON { response in
                switch response.result {
                case .success(_):
                    handleTheResponse(response, requestObject: request, success: success, failure: failure)
                case .failure(let encodingError):
                    failure(request.urlRequest, encodingError as NSError)
                }
            }
        } else {
            failure(request.urlRequest, networkError())
        }
    }
    
    ///  This method will send upload request by using Alamofire with particular URLRequestConvertible implemented Object and fileurlstring with key.
    /// - parameter request: It's a mutable request object which confirms to URLRequestConvertible protocol.
    /// - parameter multipartData: A structure which has the json data and list of image urls to upload the iamges.
    /// - parameter fileUrlString: File filepathurl string. Note: This should be for sure File path URl string.
    /// - parameter headers: Any custom http headers for the request, which defaults to nil
    /// - parameter success: A closure to be executed once the request has been succesfully finished.
    /// - parameter failure: A closure to be executed once the request has been finished with failure reason.
    static func uploadRequest(_ request: Request, multipartData: MultiPartData, headers: [String: String]? = nil, success: @escaping ((_ request: URLRequest?, _ response: AnyObject?) -> Void), failure: @escaping ((_ request: URLRequest?, _ error: NSError) -> Void)) {
        if reachability?.isReachable == true {
            NetworkManager.headers = headers
            if debugLog == true {
                #if DEBUG || DEV || TESTSERVER
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Api Request: \(String(describing: request.urlRequest)) \n Request Method: \(request.urlRequest?.httpMethod ?? "") \n Headers: \(request.urlRequest?.allHTTPHeaderFields ?? [:]) \n TimeOutInterval: \(String(describing: request.urlRequest?.timeoutInterval))")
                #endif
            }
            AF.upload(multipartFormData: { (multipartFormData) in
                if let fileUrlStrings = multipartData.multipartImageFileUrl {
                    for fileUrlString in fileUrlStrings {
                        let imageDataKey = multipartData.multipartImageDataKey ?? "image"
                        let pathName = URL(fileURLWithPath: fileUrlString).lastPathComponent
                        
                        //As we need to different the content type and perform size reduction for iamges, we used below condition.
                        if let image = UIImage(contentsOfFile: fileUrlString) {
                            if let data = image.jpegData(compressionQuality: 1.0) {
                                let kiloBytes = data.count / 1024
                                let megaBytes = Double(kiloBytes / 1024)
                                var percentage = 1.0
                                if megaBytes > multipartData.multipartMaxFileSize && multipartData.multipartMaxFileSize > 0 {
                                    percentage = multipartData.multipartMaxFileSize / megaBytes
                                }
                                
                                percentage = percentage > 1.0 ? 1.0: percentage
                                percentage = percentage < 0.1 ? 0.1: percentage
                                
                                if let reducedData = image.jpegData(compressionQuality: CGFloat(percentage)) {
                                    multipartFormData.append(reducedData, withName: imageDataKey, fileName: pathName, mimeType: "image/jpeg")
                                    
                                }
                            }
                            
                        } else {
                            do {
                                let fileUrl = URL(fileURLWithPath: fileUrlString)
                                let rawData = try Data(contentsOf: fileUrl)
                                multipartFormData.append(rawData, withName: imageDataKey, fileName: pathName, mimeType: "application/octet-stream")
                            } catch _ as NSError {
                                
                            }
                        }
                    }
                }
                
                if multipartData.multipartImageDataKey != "file" {
                    if let jsonData = getJsonData(multipartData.multipartTextJson) {
                        multipartFormData.append(jsonData, withName: multipartData.multipartTextDataKey ?? "json")
                    }
                }
            }, with: request).responseJSON { response in
                switch response.result {
                case .success(_):
                    handleTheResponse(response, requestObject: request, success: success, failure: failure)
                case .failure(let encodingError):
                    failure(request.urlRequest, encodingError as NSError)
                }
            }
        } else {
            failure(request.urlRequest, networkError())
        }
    }
    
    ///  This method will serialize the json Dict to json data, if it is not convertable it will send nil object.
    /// - parameter jsonDict: Dictionary of parameters which needs to pass it as json object in multipart Api's.
    /// - returns: NSData
    static func getJsonData(_ jsonDict: [String: Any]) -> Data? {
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch _ as NSError {
//            log?.info.message(error.localizedDescription)
        }
        return jsonData
    }
    
    ///  This method will parse the response and check for HTTP session code and callback success or failure response based on status codes.
    /// - parameter response: It's an alamofire response object, which we get from Alamofire request execution.
    /// - parameter success: A closure to be executed once the request has been succesfully finished.
    /// - parameter failure: A closure to be executed once the request has been finished with failure reason.
    static func handleTheResponse(_ response: AFDataResponse<Any>, requestObject: Request?, success: @escaping ((_ request: URLRequest?, _ response: AnyObject?) -> Void), failure: @escaping ((_ request: URLRequest?, _ error: NSError) -> Void)) {
        logTheResponse(response, requestObject: requestObject)
        switch response.result {
        case .success(let value):
            let responseStatusCode: Int? = response.response?.statusCode
            if  responseStatusCode != 200 {
                let responseDict = value as? [String: AnyObject]
                
                if let responseDict = responseDict, let errorMsg = responseDict[ThisConstants.errorMsgKey] as? String {
                    let errorCode = responseDict[ThisConstants.errorCode] as? Int ?? responseStatusCode
                    let error: NSError = getTheErrorObject(errorMsg, errorResponse: responseDict, errorCode: errorCode, response: response)
                    failure(response.request, error)
                } else if let responseDict = responseDict, let errorMsg = responseDict[ThisConstants.idmErrorMsgKey] as? String {
                    let errorCode = responseDict[ThisConstants.errorCode] as? Int ?? responseStatusCode
                    let error: NSError = getTheErrorObject(errorMsg, errorResponse: responseDict, errorCode: errorCode, response: response)
                    failure(response.request, error)
                } else {
                    failure(response.request, customUnknownError())
                }
            } else {
                if responseInSwiftyJSon == true {
                    let swiftyJsonResponse = JSON(value)
                    success(response.request, swiftyJsonResponse.dictionaryObject as AnyObject?)
                } else if removeKeysWithNullValues == true {
                    success(response.request, JSONObjectByRemovingKeysWithNullValues(value as AnyObject))
                } else {
                    success(response.request, value as AnyObject)
                }
            }
        case .failure(let error):
            failure(response.request, localizedError(error as NSError))
        }
    }
    
    fileprivate static func logTheResponse(_ response: AFDataResponse<Any>, requestObject: Request?) {
        if debugLog == true {
            #if DEBUG || DEV || TESTSERVER
            switch response.result {
            case .success(let value):
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Suceess: \n RespectiveRequest: \(response.request?.description ?? "") \n TimeOutInterval: \(response.request?.timeoutInterval ?? 8) \n Request Parameters: \(requestObject?.requestParamters?.description ?? "No Paramaters") \n StatusCode: \(response.response?.statusCode ?? 0) \n Response: \(JSONObjectByRemovingKeysWithNullValues(value as AnyObject))")
            case .failure(let error):
                print("\n\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\n")
                print("Failure: \n RespectiveRequest: \(response.request?.description ?? "") \n TimeOutInterval: \(response.request?.timeoutInterval ?? 8) \n Request Parameters: \(requestObject?.requestParamters?.description ?? "No Paramaters") \n StatusCode: \(response.response?.statusCode ?? 0) \n Response: \(error)")
            }
            #endif
        }
    }

    ///  This method removes all NSNull values from a JSON object
    /// - parameter JSONObject: Json object in which NSNull values to be removed.
    /// - returns: AnyObject
    fileprivate static func JSONObjectByRemovingKeysWithNullValues(_ JSONObject: AnyObject) -> AnyObject {
        switch JSONObject {
        case let JSONObject as [AnyObject]:
           return JSONObject.map { (JSONObjectByRemovingKeysWithNullValues($0)) } as AnyObject
        case let JSONObject as [String: AnyObject]:
            var mutableDictionary = JSONObject
            for (key, value) in JSONObject {
                switch value {
                case _ as NSNull:
                    mutableDictionary.removeValue(forKey: key)
                default:
                    mutableDictionary[key] = JSONObjectByRemovingKeysWithNullValues(value)
                }
            }
            return mutableDictionary as AnyObject
        default:
            return JSONObject
        }
    }
        
}

///  This extension will provide functions to get custom and localized errors.
extension Helper {
    static func customError(_ errorDomain: String = ThisConstants.errorDomain, errorCode: Int = 0, errorMessage: String) -> NSError {
        let error = NSError(domain: errorDomain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        return error
    }
    
    static func customUnknownError() -> NSError {
        let error = customError(errorMessage: NSLocalizedString(ThisConstants.genericErrorMessgae, comment: ThisConstants.genericErrorMessgae))
        return error
    }
    
    static func networkError() -> NSError {
        let error = customError(errorCode: GeneralConstants.noNetworkErrorCode, errorMessage: ThisConstants.networkErrorMessage)
        return error
    }
    
    ///This method is used to parse the data within the errorObject and add the info to the userInfo dict of the errorObject.
    static func getTheErrorObject(_ errorMessgae: String, errorResponse: [String: Any]? = nil, errorCode: Int?, response: AFDataResponse<Any>?) -> NSError {
        var code: Int?
        var userInfo: [String: Any] = [NSLocalizedDescriptionKey: errorMessgae]
        userInfo[GeneralConstants.supportNumber] = errorResponse?[GeneralConstants.supportNumber] as? String
        userInfo[GeneralConstants.supportEmail] = errorResponse?[GeneralConstants.supportEmail] as? String
        userInfo[GeneralConstants.errorResponse] = errorResponse
        code = errorCode

        //This is explictly used for "mobileUserNameMismatchErrorDomain"
        switch errorCode {
        case ThisConstants.mobileUserNameMisMatchErrorCode:
            if let errorData = errorResponse?[ThisConstants.errorData] as? [String: Any] {
                userInfo[GeneralConstants.oldEmail] = errorData[GeneralConstants.oldEmail] as? String
                userInfo[GeneralConstants.newEmail] = errorData[GeneralConstants.newEmail] as? String
                userInfo[GeneralConstants.userName] = errorData[GeneralConstants.userName] as? String
            }
        case GeneralConstants.forceUpgradeRequired, GeneralConstants.forceUpgradeRecommended:
            //In handleForceUpgradeError method we are considering errorCode as a response Satus code. So here we assigning status code to the error code.
            code = APIConstantsKeys.forceUpgradeErrorCode
        default:
            break
        }
        //Setting isEmployee value which is in error object. Considering this value to track the firebase analytics when the login fails for employee
        if let errorData = errorResponse?[ThisConstants.errorData] as? [String: Any], let isEmployee = errorData[GeneralConstants.isEmployee] as? Bool {
            userInfo[GeneralConstants.isEmployee] = isEmployee
        }
        let error: NSError = NSError(domain: ThisConstants.errorDomain, code: code ?? 400, userInfo: userInfo)
        return error
    }
    
    static func localizedError(_ theError: NSError) -> NSError {
        var error: NSError!
        if theError.domain == kCFErrorDomainCFNetwork as String || theError.domain == NSURLErrorDomain {
            let errorCodeString = "\(theError.code)"
            var localizedErrorStr = NSLocalizedString(errorCodeString, tableName: "NetworkErrors", bundle: Bundle.main, value: "", comment: "")
            if localizedErrorStr.isEmpty == true || localizedErrorStr == errorCodeString {
                localizedErrorStr = theError.localizedDescription
            }
            
            var userInfo = theError.userInfo
            userInfo[NSLocalizedDescriptionKey] = localizedErrorStr
            error = NSError(domain: theError.domain, code: theError.code, userInfo: userInfo)
        } else {
            error = customUnknownError()
        }
        return error
    }
}

extension NetworkManager {
    struct  ThisConstants {
        static let errorMsgKey = "errorMessage"
        static let idmErrorMsgKey = "message"
        static let errorCode = "errorCode"
        static let errorDomain = "ErrorDomain"
        static let errorData = "data"
        static let genericErrorMessgae = "Oops something is not quite right. Please try again."
        static let networkErrorMessage = "Server is not reachable, please try after sometime."
        static let mobileUserNameMisMatchErrorCode = 1008
    }
}
