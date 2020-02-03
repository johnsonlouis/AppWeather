//
//  AppDelegate.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Property

    var window: UIWindow?
	var appCoordinator: SplashCoordinator?

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            return true
        }
        window = UIWindow(frame: UIScreen.main.bounds)
		appCoordinator = SplashCoordinatorImpl(window: window)
		appCoordinator?.startRoot()
        return true
    }
}
