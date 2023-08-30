//
//  PurchaseService.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import Foundation
import Combine

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

public struct VerifyUserNameRequest: Encodable {
    public let email: String
}

public struct getUserProfileRequest: Encodable {
    
}

// MARK: - VerifyUser
public struct VerifyUserNameResponse: Codable {
    let data: DataObject
    let success: Bool
}

// MARK: - DataClass
public struct DataObject: Codable {
    let signupToken: String
    let isSignedUp: Bool
    let status: String
    let userId: Int
    let userType: String
    let isActivated: Bool
    let lob, email, contactType: String
    let isSsoEnabled: Bool
    let companyLogo: String
    let iconUrl: String
}

public struct UserProfile: Codable {
    let data: DataInfo
    let success: Bool
    let timestamp: Int
}

// MARK: - DataClass
public struct DataInfo: Codable {
    let displayName: String
    let imageURL: String
    let aboutMe, title, dob, userRole: String
    let userID: Int
    let userObjID, sfdcContactID, sfdcAccountID, firstName: String
    let lastName, email, marketTeam, lob: String
    let accountName, accountType: String
    let companyID: Int
    let pxRole, orgID, employeeID: String

    enum CodingKeys: String, CodingKey {
        case displayName
        case imageURL = "imageUrl"
        case aboutMe, title, dob, userRole
        case userID = "userId"
        case userObjID = "userObjId"
        case sfdcContactID = "sfdcContactId"
        case sfdcAccountID = "sfdcAccountId"
        case firstName, lastName, email, marketTeam, lob, accountName, accountType
        case companyID = "companyId"
        case pxRole
        case orgID = "orgId"
        case employeeID = "employeeId"
    }
}
