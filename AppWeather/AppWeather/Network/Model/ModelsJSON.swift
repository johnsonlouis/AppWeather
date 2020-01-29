//
//  ModelsJSON.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

struct ResultJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case code = "cod", message, count = "cnt", list, city
    }
    let code: String
    let message: Int
    let count: Int
    let list: [ResultItemJSON]
    let city: CityJSON
}

struct ResultItemJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case forecastedTime = "dt", main, weather, clouds, wind, forecastedTimeISO = "dt_txt"
    }
    let forecastedTime: Int // Time of data forecasted, unix, UTC
    let main: ResultMainJSON
    let weather: [WeatherJSON]
    let clouds: CloudJSON
    let wind: WindJSON
    let forecastedTimeISO: String // Time of data forecasted, ISO, UTC
}

struct ResultMainJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure
        case humidity
    }

    let temperature: Float
    let feelsLike: Float?
    let minTemperature: Float
    let maxTemperature: Float
    let pressure: Int // Atmospheric pressure on the sea level by default, hPa
    let humidity: Int
}

struct WeatherJSON: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CloudJSON: Decodable {
    let all: Int
}

struct WindJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case speed, degrees = "deg"
    }
    let speed: Float
    let degrees: Int? // Wind direction, degrees (meteorological)
}

struct CityJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, name, coordinates = "coord", country, timezone, sunrise, sunset
    }
    let id: Int
    let name: String
    let coordinates: CoordinateJSON
    let country: String
    let timezone: Double
    let sunrise: Double
    let sunset: Double
}

struct CoordinateJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case latitutde = "lat", longitude = "lon"
    }
    let latitutde: Double
    let longitude: Double
}

struct DetailsJSON: Decodable {
	let id: Int
	let name: String
	let coord: CoordinateJSON
	let weather: [WeatherJSON]
	let main: ResultMainJSON
	let wind: WindJSON
	let cod: Int
}
