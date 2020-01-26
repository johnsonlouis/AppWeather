//
//  SplashModule.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

enum SplashModule {

    static func makeRoot() -> UINavigationController {
        let rootViewController = SplashModule.makeView()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        return rootNavigationController
    }

    static func makeView() -> UIViewController {
        let viewController = StoryboardScene.Main.initialScene.instantiate()
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
