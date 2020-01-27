//
//  UIDevice+Extension.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

extension UIDevice {
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
