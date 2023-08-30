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
         print("\nURL - \(req)")
         print("\nRequest Type - \(req.httpMethod)")
         let bodyString = String(data: req.body ?? Data(), encoding: .utf8)
         print("\nRequest body =\(String(describing: bodyString))")
         print("\nRequest header = \(String(describing: req.headers))")
         
         return URLSession.shared
             .dataTaskPublisher(for: req.buildURLRequest(with: url))
             .tryMap { output in
                      // throw an error if response is nil
                 guard output.response is HTTPURLResponse else {
                     throw NetworkError.serverError(code: 0, error: "Server error")
                 }
                 return output.data
             }
             .decode(type: T.self, decoder: JSONDecoder())
             .mapError { error in
                        // return error if json decoding fails
                 NetworkError.invalidJSON(String(describing: error))
             }
             .eraseToAnyPublisher()
    }
}

/*
 // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
  return URLSession.shared
      .dataTaskPublisher(for: req.buildURLRequest(with: url))
      .tryMap { data, response -> T in
          guard
             let response = response as? HTTPURLResponse,
             (200..<300).contains(response.statusCode)
          else {
              throw NetworkError.serverError(code: 0, error: "Server error")
          }
          // Create JSON Decoder
          let decoder = JSONDecoder()
          
          // Configure JSON Decoder
          decoder.dateDecodingStrategy = .secondsSince1970
          
          do {
              return try decoder.decode(T.self, from: data)
          } catch {
              print("Unable to Decode Response \(error)")
              throw NetworkError.invalidJSON(String(describing: error))
          }
      }
      .mapError { error in
                 // return error if json decoding fails
          NetworkError.invalidJSON(String(describing: error))
      }
      .eraseToAnyPublisher()

 */
