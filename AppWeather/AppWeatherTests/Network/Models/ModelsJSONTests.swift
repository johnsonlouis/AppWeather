//
//  ModelsJSONTests.swift
//  AppWeatherTests
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import XCTest
@testable import AppWeather

class ResultJSONTests: XCTestCase {

    func test_decode() throws {
        // Given
        let data = File.read(filename: "5days_mock")!

        // When
        let resultJSON = try JSONDecoder().decode(ResultJSON.self, from: data)

        // Then
        XCTAssertNotNil(resultJSON)
        XCTAssertEqual(resultJSON.code, "200")
        XCTAssertEqual(resultJSON.message, 0)
        XCTAssertEqual(resultJSON.count, 40)
        XCTAssertNotNil(resultJSON.list)
        XCTAssertEqual(resultJSON.list.count, 40)
        XCTAssertNotNil(resultJSON.city)
    }

    func test_decode_main() throws {
        // Given
        let jsonString =
        """
        {
          "temp": 6.69,
          "feels_like": 2.69,
          "temp_min": 6.69,
          "temp_max": 8.03,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 1005,
          "humidity": 82,
          "temp_kf": -1.34
        }
        """

        let data = jsonString.data(using: .utf8)!

        // When
        let mainJSON = try JSONDecoder().decode(ResultMainJSON.self, from: data)

        // Then
        XCTAssertNotNil(mainJSON)
        XCTAssertEqual(mainJSON.temperature, 6.69)
        XCTAssertEqual(mainJSON.feelsLike, 2.69)
        XCTAssertEqual(mainJSON.minTemperature, 6.69)
        XCTAssertEqual(mainJSON.maxTemperature, 8.03)
        XCTAssertEqual(mainJSON.pressure, 1015)
        XCTAssertEqual(mainJSON.humidity, 82)
    }

    func test_decode_weather() throws {
        // Given
        let jsonString =
        """
        {
          "id": 803,
          "main": "Clouds",
          "description": "nuageux",
          "icon": "04n"
        }
        """

        let data = jsonString.data(using: .utf8)!

        // When
        let weatherJSON = try JSONDecoder().decode(WeatherJSON.self, from: data)

        // Then
        XCTAssertNotNil(weatherJSON)
        XCTAssertEqual(weatherJSON.id, 803)
        XCTAssertEqual(weatherJSON.main, "Clouds")
        XCTAssertEqual(weatherJSON.description, "nuageux")
        XCTAssertEqual(weatherJSON.icon, "04n")
    }

    func test_decode_cloud() throws {
        // Given
        let jsonString =
        """
        {
          "all": 65
        }
        """

        let data = jsonString.data(using: .utf8)!

        // When
        let cloudJSON = try JSONDecoder().decode(CloudJSON.self, from: data)

        // Then
        XCTAssertNotNil(cloudJSON)
        XCTAssertEqual(cloudJSON.all, 65)
    }

    func test_decode_wind() throws {
        // Given
        let jsonString =
        """
        {
          "speed": 3.78,
          "deg": 205
        }
        """

        let data = jsonString.data(using: .utf8)!

        // When
        let windJSON = try JSONDecoder().decode(WindJSON.self, from: data)

        // Then
        XCTAssertNotNil(windJSON)
        XCTAssertEqual(windJSON.speed, 3.78)
        XCTAssertEqual(windJSON.degrees, 205)
    }

    func test_decode_city() throws {
        // Given
        let jsonString =
        """
        {
          "id": 6455259,
          "name": "Lutèce",
          "coord": {
            "lat": 48.8565,
            "lon": 2.3524
          },
          "country": "FR",
          "timezone": 3600,
          "sunrise": 1580023745,
          "sunset": 1580056598
        }
        """

        let data = jsonString.data(using: .utf8)!

        // When
        let cityJSON = try JSONDecoder().decode(CityJSON.self, from: data)

        // Then
        XCTAssertNotNil(cityJSON)
        XCTAssertEqual(cityJSON.id, 6455259)
        XCTAssertEqual(cityJSON.name, "Lutèce")
        XCTAssertNotNil(cityJSON.coordinates)
        XCTAssertEqual(cityJSON.coordinates.latitutde, 48.8565)
        XCTAssertEqual(cityJSON.coordinates.longitude, 2.3524)
        XCTAssertEqual(cityJSON.country, "FR")
        XCTAssertEqual(cityJSON.timezone, 3600)
        XCTAssertEqual(cityJSON.sunrise, 1580023745)
        XCTAssertEqual(cityJSON.sunset, 1580056598)
    }

    func test_decode_coordinate() throws {
        // Given
        let jsonString =
        """
        {
          "lat": 48.8565,
          "lon": 2.3524
        }
        """

        let data = jsonString.data(using: .utf8)!

        // When
        let coordinateJSON = try JSONDecoder().decode(CoordinateJSON.self, from: data)

        // Then
        XCTAssertNotNil(coordinateJSON)
        XCTAssertEqual(coordinateJSON.latitutde, 48.8565)
        XCTAssertEqual(coordinateJSON.longitude, 2.3524)
    }

	func test_decode_details() throws {
		let jsonString =
		"""
        {
          "coord": {"lon": -122.08,"lat": 37.39},
          "weather": [
        	{
        	  "id": 800,
        	  "main": "Clear",
        	  "description": "clear sky",
        	  "icon": "01d"
        	}
          ],
          "base": "stations",
          "main": {
        	"temp": 282.55,
        	"feels_like": 281.86,
        	"temp_min": 280.37,
        	"temp_max": 284.26,
        	"pressure": 1023,
        	"humidity": 100
          },
          "visibility": 16093,
          "wind": {
        	"speed": 1.5,
        	"deg": 350
          },
          "clouds": {
        	"all": 1
          },
          "dt": 1560350645,
          "sys": {
        	"type": 1,
        	"id": 5122,
        	"message": 0.0139,
        	"country": "US",
        	"sunrise": 1560343627,
        	"sunset": 1560396563
          },
          "timezone": -25200,
          "id": 420006353,
          "name": "Mountain View",
          "cod": 200
        }
        """

		let data = jsonString.data(using: .utf8)!

		// When
		let detailsJSON = try JSONDecoder().decode(DetailsJSON.self, from: data)

		// Then
		XCTAssertNotNil(detailsJSON)
		XCTAssertNotNil(detailsJSON.coord)
		XCTAssertEqual(detailsJSON.coord.latitutde, 37.39)
		XCTAssertEqual(detailsJSON.coord.longitude, -122.08)
		XCTAssertNotNil(detailsJSON.main)
		XCTAssertEqual(detailsJSON.main.temperature, 282.55)
		XCTAssertEqual(detailsJSON.main.feelsLike, 281.86)
		XCTAssertEqual(detailsJSON.main.minTemperature, 280.37)
		XCTAssertEqual(detailsJSON.main.maxTemperature, 284.26)
		XCTAssertEqual(detailsJSON.main.pressure, 1023)
		XCTAssertEqual(detailsJSON.main.humidity, 100)
		XCTAssertNotNil(detailsJSON.wind)
		XCTAssertEqual(detailsJSON.wind.speed, 1.5)
		XCTAssertEqual(detailsJSON.wind.degrees, 350)
		XCTAssertEqual(detailsJSON.cod, 200)
		XCTAssertEqual(detailsJSON.name, "Mountain View")
		XCTAssertEqual(detailsJSON.id, 420006353)
	}
}
