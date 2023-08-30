//
//  BaseRequest.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import Combine
import Foundation

public protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
