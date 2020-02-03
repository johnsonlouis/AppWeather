//
//  UIStoryboard+Extension.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 03/02/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

// swiftlint:disable force_cast

import UIKit

extension UIStoryboard {

	static var main: UIStoryboard {
		return UIStoryboard(name: "Main", bundle: nil)
	}

	var homeViewController: HomeViewController {
		return instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
	}

	var splashViewController: SplashViewController {
		return instantiateInitialViewController() as! SplashViewController
	}

	var detailsViewController: DetailsViewController {
		return instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
	}
}
