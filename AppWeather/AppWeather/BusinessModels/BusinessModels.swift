//
//  BusinessModels.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

struct HomeInfo {
    let city: String
    let description: String?
    let currentTemperature: Float?
    let daysInfo: [DayInfo]
}

struct DayInfo {
    let date: Date
    let minTemperature: Float
    let maxTemperature: Float
	let iconUrl: String?
}

struct Detailnfo {
	let name: String
	let description: String?
	let icon: String?
	let temperature: Float
	let minTemperature: Float
	let maxTemperature: Float
	let temperatureFeels: Float?
	let pressure: Int
	let humidity: Int
	let windSpeed: Float
}
