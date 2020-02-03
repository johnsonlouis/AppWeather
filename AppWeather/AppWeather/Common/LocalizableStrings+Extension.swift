//
//  LocalizableStrings+Extension.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 03/02/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Foundation

extension String {

	func localized(bundle: Bundle = .main, tableName: String = "AppWeather-localizable") -> String {
		return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
	}
}
