//
//  Client.swift
//  CombineNet
//
//  Created by Hao Wang on 2020/1/23.
//  Copyright © 2020 Tuluobo. All rights reserved.
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public struct Client {
    
    public struct Response<T> {
        public var value: T
        public var response: URLResponse
    }
    
    public static func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    public static func execute<T: Decodable>(
        _ urlString: String,
        _ method: HTTPMethod = .GET,
        _ headers: [String: String] = [:],
        _ data: [String: String] = [:],
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Response<T>, Error> {
        guard let url = URL(string: urlString) else {
              return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if method == .GET {
            request.url = request.url?.appendingQueryParameters(data)
        } else {
            do {
                let data = try JSONSerialization.data(withJSONObject: data, options: [])
                request.httpBody = data
            } catch let error {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

public extension Client {
    static func get<T: Decodable>(
        _ urlString: String,
        _ headers: [String: String] = [:],
        _ data: [String: String] = [:],
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Response<T>, Error> {
        return self.execute(urlString, .GET, headers, data, decoder)
    }
    
    static func post<T: Decodable>(
        _ urlString: String,
        _ headers: [String: String] = [:],
        _ data: [String: String] = [:],
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Response<T>, Error> {
        return self.execute(urlString, .POST, headers, data, decoder)
    }
}
