//
//  UIColor+Extension.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 03/02/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

extension UIColor {

	static func hexStringToUIColor(hex: String) -> UIColor {
		var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if cString.hasPrefix("#") {
			cString.remove(at: cString.startIndex)
		}

		if cString.count != 6 {
			return UIColor.gray
		}

		var rgbValue: UInt64 = 0
		Scanner(string: cString).scanHexInt64(&rgbValue)

		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}

	static var appBlack: UIColor {
		return UIColor.hexStringToUIColor(hex: "#000000")
	}

	static var appWhite: UIColor {
		return UIColor.hexStringToUIColor(hex: "#FFFFFF")
	}

	static var appBlue: UIColor {
		return UIColor.hexStringToUIColor(hex: "#3885AF")
	}

	static var appGray: UIColor {
		return UIColor.hexStringToUIColor(hex: "#494949")
	}

	static var appRed: UIColor {
		return UIColor.hexStringToUIColor(hex: "#ed6341")
	}

	static var appYellow: UIColor {
		return UIColor.hexStringToUIColor(hex: "#f7c544")
	}
}
