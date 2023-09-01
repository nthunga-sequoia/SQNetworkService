//
//  ServiceUsage.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import Foundation
import Combine

typealias VMFailure = (_ errorObject: NetworkError) -> Void
typealias VMSuccess = () -> Void
typealias VMSuccessWithMsg = (_ message: String?) -> Void
typealias VMCompletion = (_ response: Any?) -> Void
typealias VMCompletionWithTitlesubTitle = (_ titlt: String?, _ subTitle: String?) -> Void

class AuthenticationManager {
    
    func veriyUserName(emailId: String, _ failure: @escaping VMFailure, success: @escaping VMSuccess) {
        var subscriptions = Set<AnyCancellable>()
        let purchaseRequest = VerifyUserNameRequest(email: emailId)
        let service = VerifyUserNameService(networkRequest: NativeRequestable(), environment: .development)
        
            service.verifyUserName(request: purchaseRequest)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Nothing much to do here")
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                    failure(error)
                }
            } receiveValue: { response in
                print("\nVerify Username API successful\n")
                success()
            }
            .store(in: &subscriptions)
    }
    
    func getUserProfile() {
        var subscriptions = Set<AnyCancellable>()
        let userProfileRequest = getUserProfileRequest()
        let service = VerifyUserNameService(networkRequest: NativeRequestable(), environment: .development)
        
            service.getUserProfile(request: userProfileRequest)
            .sink { completion in
                switch completion {
                case .finished:
                    print("\nGet User profile API finished")
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                }
            } receiveValue: { response in
                print("\nGet user profile API successful\n")
            }
            .store(in: &subscriptions)
    }
}










