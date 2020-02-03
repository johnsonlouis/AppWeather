//
//  HomeCoordinator.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

protocol HomeCoordinator {
	func start(with cityId: Int)
	func startDetails(with cityId: Int)
}

class HomeCoordinatorImpl {

	// MARK: - Property

	private let navigationController: UINavigationController

	// MARK: - Initialize

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

// MARK: - HomeCoordinator

extension HomeCoordinatorImpl: HomeCoordinator {

	func start(with cityId: Int) {
		let homeViewController = UIStoryboard.main.homeViewController
		let model = HomeService(network: Network())
		let viewModel = HomeViewModelImpl(model: model, coordinator: self)
		viewModel.cityId = cityId
		viewModel.view = homeViewController
		homeViewController.viewModel = viewModel
		navigationController.setViewControllers([homeViewController], animated: false)
	}

	func startDetails(with cityId: Int) {
		let detailsCoordinator = DetailsCoordinatorImpl(navigationController: navigationController)
		detailsCoordinator.start(with: cityId)
	}
}
