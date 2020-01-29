//
//  HomeWorkerTests.swift
//  AppWeatherTests
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import XCTest
@testable import AppWeather

class HomeWorkerTests: XCTestCase {
    var sut: HomeWorker!
    var networkMock: NetworkProtocolMock<ResultJSON>!

    override func setUp() {
        networkMock = NetworkProtocolMock()
        sut = HomeWorker(network: networkMock)
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_fetchInfos_resource() throws {
		// Given
		let cityId = 1234

        // When
		sut.fetchInfos(cityId: cityId) { _ in }

        // Then
        XCTAssertEqual(networkMock.requestResource?.url, "https://api.openweathermap.org/data/2.5/forecast")
        XCTAssertEqual(networkMock.requestResource?.parameters, ["id": "1234",
                                                                 "appid": "5c9a5519f58bd542743e739b83ad4c2f",
                                                                 "lang": Locale.current.languageCode ?? "en",
                                                                 "units": "metric"])
        XCTAssertNil(networkMock.requestResource?.headers)
        XCTAssertEqual(networkMock.requestResource?.timeoutInterval, 60)
        XCTAssertEqual(networkMock.requestResource?.method, .get)
    }

    func test_fetchInfos_success() throws {
        // Given
		let cityId = 1234

        let data = File.read(filename: "5days_mock")!

        let resultJSON = try JSONDecoder().decode(ResultJSON.self, from: data)
        networkMock.requestClosure = { completionHandler in
            completionHandler(.success(resultJSON))
        }

        var expectedValue: HomeInfo?
        var expectedError: Error?

        // When
        sut.fetchInfos(cityId: cityId) { result in
            switch result {
            case .success(let decodable):
                expectedValue = decodable
            case .failure(let error):
                expectedError = error
            }
        }

        // Then
        XCTAssertNotNil(expectedValue)
        XCTAssertNil(expectedError)
    }

    func test_fetchInfos_failure() throws {
        // Given
		let cityId = 1234

        networkMock.requestClosure = { completionHandler in
            completionHandler(.failure(NetworkError.invalidRequest))
        }

        var expectedValue: HomeInfo?
        var expectedError: Error?

        // When
        sut.fetchInfos(cityId: cityId) { result in
            switch result {
            case .success(let decodable):
                expectedValue = decodable
            case .failure(let error):
                expectedError = error
            }
        }

        // Then
        XCTAssertNil(expectedValue)
        XCTAssertNotNil(expectedError)
    }
}
