//
//  DetailsCoordinator.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 28/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

protocol DetailsCoordinator {
	func start(with cityId: Int)
}

class DetailsCoordinatorImpl {

	// MARK: - Property

	private let navigationController: UINavigationController

	// MARK: - Initialize

	required init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

// MARK: - HomeCoordinator

extension DetailsCoordinatorImpl: DetailsCoordinator {

	func start(with cityId: Int) {
		let detailsViewController = UIStoryboard.main.detailsViewController
		let model = DetailsService(network: Network())
		let viewModel = DetailsViewModelImpl(model: model)
		viewModel.cityId = cityId
		viewModel.view = detailsViewController
		detailsViewController.viewModel = viewModel
		navigationController.pushViewController(detailsViewController, animated: true)
	}
}
