//
//  ModelsJSON+Extension.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

extension ResultItemJSON {

    var forecastedTimeDate: Date? {
        DateFormatter.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return DateFormatter.dateFormatter.date(from: forecastedTimeISO)
    }

    var forecastedTimeIsoFormatted: String? {
        guard let forecastedTimeDate = forecastedTimeDate  else {
            return nil
        }
        DateFormatter.dateFormatter.dateFormat = "yyyy-MM-dd"
        return DateFormatter.dateFormatter.string(from: forecastedTimeDate)
    }
}
