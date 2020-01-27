//
//  Date+Extension.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

extension Date {

    func inSameDayAsDate(date: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day, .month, .year], from: self, to: date)
        return diff.day == 0
    }

    var dayAsString: String {
        DateFormatter.dateFormatter.dateFormat = "EEEE"
        return DateFormatter.dateFormatter.string(from: self)
    }
}
