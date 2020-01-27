//
//  NetworkProtocolMock.swift
//  AppWeatherTests
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

@testable import AppWeather
import Foundation

class NetworkProtocolMock<T: Decodable>: NetworkProtocol {

    var requestCallsCount = 0
    var requestCalled: Bool {
        return requestCallsCount > 0
    }

    var requestResource: NetworkResource?
    var requestClosure: (((Result<Decodable, Error>) -> Void?) -> Void)?
    func request<T: Decodable>(resource: NetworkResource,
                               type: T.Type,
                               completionHandler: @escaping (Result<Decodable, Error>) -> Void) {
        requestCallsCount += 1
        requestResource = resource
        requestClosure?(completionHandler)
    }
}
