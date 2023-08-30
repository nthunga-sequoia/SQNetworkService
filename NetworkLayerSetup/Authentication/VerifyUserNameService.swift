//
//  PurchaseService.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import Foundation
import Combine

public typealias Headers = [String: String]

protocol VerifyUserNameServiceable {
    func verifyUserName(request: VerifyUserNameRequest) -> AnyPublisher<VerifyUserNameResponse, NetworkError>
    func getUserProfile(request: getUserProfileRequest) -> AnyPublisher<UserProfile, NetworkError>
}

class VerifyUserNameService: VerifyUserNameServiceable {
    func getUserProfile(request: getUserProfileRequest) -> AnyPublisher<UserProfile, NetworkError> {
        let endpoint = VerifyUsernameEndpoints.getUserProfile(request: request)
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    func verifyUserName(request: VerifyUserNameRequest) -> AnyPublisher<VerifyUserNameResponse, NetworkError> {
        let endpoint = VerifyUsernameEndpoints.verifyUsername(request: request)
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
  // inject this for testability
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
}


enum VerifyUsernameEndpoints {
    
  // organise all the end points here for clarity
    case verifyUsername(request: VerifyUserNameRequest)
    case getUserProfile(request: getUserProfileRequest)

  // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .verifyUsername:
            return .POST
        case .getUserProfile:
            return .GET
        }
    }
    
  // compose the NetworkRequest
    func createRequest(token: String = "b19f5da6-7bec-4315-940f-a1673d1107a4", environment: Environment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        headers["appVersionNumber"] = "6.9.0"
        headers["deviceUUId"] = "79DA48BD-23FA-4713-B6F0-59FB6812AAD8"
        headers["deviceName"] = "Simulator"
        headers["deviceTypeId"] = "2"
        headers["buildNumber"] = "1160"
        headers["locale-timezone"] = "Asia/Kolkata"
        headers["deviceOSVersion"] = "16.4"
        headers["apiToken"] = token
        headers["token"] = token
        headers["agent"] = "client"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .verifyUsername(let request):
            return request
        default:
            return nil
        }
    }
    
  // compose urls for each request
    func getURL(from environment: Environment) -> String {
        let baseUrl = environment.BaseServiceURL
        switch self {
        case .verifyUsername:
            return "\(baseUrl)/idm/v1/contacts/verify-email"
        case .getUserProfile:
            return "\(baseUrl)/uam/users/profile"
        }
    }
}
