//
//  SplashPresenter.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright (c) 2020 Johnson-Richie Louis. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashPresentationLogic {
    func presentContents(response: Splash.FetchContents.Response)
}

class SplashPresenter: SplashPresentationLogic {
    weak var viewController: SplashDisplayLogic?

	func presentContents(response: Splash.FetchContents.Response) {
        let viewModel = Splash.FetchContents.ViewModel()
        viewController?.displayContents(viewModel: viewModel)
    }
}
