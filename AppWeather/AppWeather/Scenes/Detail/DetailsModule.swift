//
//  DetailsModule.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 28/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

enum DetailsModule {

	static func makeView(with cityId: Int?) -> UIViewController {
		let viewController = StoryboardScene.Main.detailsViewController.instantiate()
		let worker = DetailsWorker(network: Network())
		let interactor = DetailsInteractor(worker: worker)
		interactor.cityId = cityId
		let presenter = DetailsPresenter()
		let router = DetailsRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
		router.dataStore?.cityId = cityId
		return viewController
	}
}
