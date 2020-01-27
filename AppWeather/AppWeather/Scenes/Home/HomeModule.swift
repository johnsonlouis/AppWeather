//
//  HomeModule.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

enum HomeModule {

    static func makeView() -> UIViewController {
        let viewController = StoryboardScene.Main.homeViewController.instantiate()
        let worker = HomeWorker(network: Network())
        let interactor = HomeInteractor(worker: worker)
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
