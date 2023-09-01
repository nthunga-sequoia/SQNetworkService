//
//  NetworkManager.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import Combine
import Foundation

public class NativeRequestable: Requestable {
    public var requestTimeOut: Float = 30

    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
     where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
         print("\nRequest Type - \(req.httpMethod)")
         let bodyString = String(data: req.body ?? Data(), encoding: .utf8)
         print("\nRequest body =\(String(describing: bodyString))")
         print("\nRequest header = \(String(describing: req.headers))")
         
         return URLSession.shared
             .dataTaskPublisher(for: req.buildURLRequest(with: url))
             .subscribe(on: DispatchQueue.global(qos: .default))
             // Map on Request response
             .tryMap({ data, response in
                 
                 // If the response is invalid, throw an error
                 guard let response = response as? HTTPURLResponse else {
                     print("\nAPI response error = \(response)")
                     throw NetworkError.serverError(code: 0, error: "Server error")
                 }
                                  
                 if !(200...299).contains(response.statusCode) {
                     print("\nAPI response code = \(response.statusCode)")
                     throw NetworkError.serverError(code: response.statusCode, error: "Server error")
                 }
                 // Return Response data
                 let responseData = try? JSONSerialization.jsonObject(with: data)
                 print("\nJSON response - \(String(describing: responseData))")
                 return data
             })
             .receive(on: DispatchQueue.main)
             // Decode data using our ReturnType
             .decode(type: T.self, decoder: JSONDecoder())
             // Handle any decoding errors
             .mapError { error in
                 NetworkError.invalidJSON(String(describing: error))
             }
             // And finally, expose our publisher
             .eraseToAnyPublisher()
    }
}


