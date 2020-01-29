//
//  DetailsInteractor.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 28/01/2020.
//  Copyright (c) 2020 Johnson-Richie Louis. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsBusinessLogic {
	func fetchContents(request: Details.FetchContents.Request)
}

protocol DetailsDataStore {
	var cityId: Int? { get set }
}

class DetailsInteractor: DetailsDataStore {

	// MARK: - Property

	var presenter: DetailsPresentationLogic?
	private let worker: DetailsWorkerProtocol
	var cityId: Int?

	init(worker: DetailsWorkerProtocol) {
		self.worker = worker
	}
}

// MARK: - DetailsBusinessLogic

extension DetailsInteractor: DetailsBusinessLogic {

	func fetchContents(request: Details.FetchContents.Request) {
		guard let cityId = cityId else {
			let response = Details.FetchContentsError.Response(error: AppWeatherError.invalidCityId)
			presenter?.presentFetchedContentsError(response: response)
			return
		}
		worker.fetch(cityId: cityId) { [weak self] in
			switch $0 {
			case .success(let detailInfo):
				let response = Details.FetchContents.Response(detailInfo: detailInfo)
				self?.presenter?.presentContents(response: response)
			case .failure(let error):
				let response = Details.FetchContentsError.Response(error: error)
				self?.presenter?.presentFetchedContentsError(response: response)
			}
		}
	}
}
