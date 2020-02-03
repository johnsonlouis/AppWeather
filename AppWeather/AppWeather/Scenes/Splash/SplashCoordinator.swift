//
//  SplashCoordinator.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright (c) 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

protocol SplashCoordinator: class {
	func startHome()
	func startRoot()
}

class SplashCoordinatorImpl {

	// MARK: - Property

	private let rootViewController = UINavigationController()
	private let window: UIWindow?

	// MARK: - Initialize
	
	required init(window: UIWindow?) {
		self.window = window
	}

	// MARK: - Private

	private var splashViewController: UIViewController {
		let viewController = UIStoryboard.main.splashViewController
		let viewModel = SplashViewModelImpl(coordinator: self)
		viewController.viewModel = viewModel
		return viewController
	}
}

// MARK: - SplashCoordinator

extension SplashCoordinatorImpl: SplashCoordinator {

	func startRoot() {
		rootViewController.setViewControllers([splashViewController], animated: false)
		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()
	}

	func startHome() {
		let parisCityId = 6455259
		let homeCoordinator = HomeCoordinatorImpl(navigationController: rootViewController)
		homeCoordinator.start(with: parisCityId)
    }
}
