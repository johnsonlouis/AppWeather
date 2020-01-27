//
//  Network.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case emptyData
}

enum NetworkMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol NetworkProtocol {
    func request<T: Decodable>(resource: NetworkResource,
                               type: T.Type,
                               completionHandler: @escaping (Result<Decodable, Error>) -> Void)
}

struct NetworkResource {
    let url: String
    let method: NetworkMethod
    let parameters: [String: String]?
    let headers: [String: String]?
    let timeoutInterval: TimeInterval
}

extension NetworkResource {

    init(url: String,
         method: NetworkMethod = .get,
         parameters: [String: String]? = nil,
         headers: [String: String]? = nil,
         timeout: TimeInterval = 60) {
        self = NetworkResource(url: url,
                               method: method,
                               parameters: parameters,
                               headers: headers,
                               timeoutInterval: timeout)
    }
}

class Network: NetworkProtocol {

    func request<T: Decodable>(resource: NetworkResource,
                               type: T.Type,
                               completionHandler: @escaping (Result<Decodable, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: resource.url) else {
            completionHandler(.failure(NetworkError.invalidRequest))
            return
        }
        var requestHttpBody: Data?
        if let params = resource.parameters {
            switch resource.method {
            case .post:
                if let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
                    requestHttpBody = httpBody
                }
            case .get:
                urlComponents.queryItems = resource.parameters?.map {
                    URLQueryItem(name: $0.key, value: $0.value)
                }
            }
        }
        guard let url = urlComponents.url else {
            completionHandler(.failure(NetworkError.invalidRequest))
            return
        }
        let urlSession = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: resource.timeoutInterval)
        urlRequest.httpBody = requestHttpBody
        urlRequest.httpMethod = resource.method.rawValue
        urlRequest.allHTTPHeaderFields = resource.headers

        let dataTask = urlSession.dataTask(with: urlRequest) { data, _, error in
            if error != nil {
                return
            }
            guard let receivedData = data else {
                completionHandler(.failure(NetworkError.emptyData))
                return
            }
            do {
                let decodableModel = try JSONDecoder().decode(T.self, from: receivedData)
                completionHandler(.success(decodableModel))
            } catch {
                completionHandler(.failure(error))
            }
        }
        dataTask.resume()
    }
}
