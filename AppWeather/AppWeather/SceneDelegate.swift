//
//  SceneDelegate.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = SplashModule.makeRoot()
        self.window?.makeKeyAndVisible()
    }
}
