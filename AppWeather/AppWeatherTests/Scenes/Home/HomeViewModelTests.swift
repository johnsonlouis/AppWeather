//
//  HomeViewModelTests.swift
//  AppWeatherTests
//
//  Created by Johnson-Riche Louis on 03/02/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

@testable import AppWeather
import XCTest

class HomeViewModelTests: XCTestCase {
	var sut: HomeViewModelImpl!
	var model: HomeModel!
	var coordinator: HomeCoordinatorMock!
	var view: HomeViewMock!

	// MARK: - Test double

	class HomeModelSuccessSpy: HomeModel {
		var fetchInfosCalled = false
		func fetchInfos(cityId: Int, completionHandler: @escaping (Result<HomeInfo, Error>) -> Void) {
			fetchInfosCalled = true
			let dayInfo = [DayInfo(date: Date(),
								   minTemperature: 0,
								   maxTemperature: 30,
								   iconUrl: "http://icon.com")]
			let homeInfo = HomeInfo(city: "Paris",
									description: "Ici c'est Paris",
									currentTemperature: 10,
									daysInfo: dayInfo)
			completionHandler(.success(homeInfo))
		}
	}

	class HomeModelFailureSpy: HomeModel {
		var fetchInfosCalled = false
		func fetchInfos(cityId: Int, completionHandler: @escaping (Result<HomeInfo, Error>) -> Void) {
			fetchInfosCalled = true
			completionHandler(.failure(NetworkError.emptyData))
		}
	}

	class HomeCoordinatorMock: HomeCoordinator {

		var startCalled = false
		var startCityId: Int?
		func start(with cityId: Int) {
			startCalled = true
			startCityId = cityId
		}

		var startDetailsCalled = false
		var startDetailsCityId: Int?
		func startDetails(with cityId: Int) {
			startDetailsCalled = true
			startDetailsCityId = cityId
		}
	}

	class HomeViewMock: HomeView {

		var updateCalled = false
		var updateViewModel: HomeViewModel?
		func update(viewModel: HomeViewModel) {
			updateCalled = true
			updateViewModel = viewModel
		}

		var updateErrorCalled = false
		var updateErrorViewModel: HomeErrorViewModel?
		func updateError(viewModel: HomeErrorViewModel) {
			updateErrorCalled = true
			updateErrorViewModel = viewModel
		}
	}

	// MARK: - Setup

	override func setUp() {
		view = HomeViewMock()
		model = HomeModelSuccessSpy()
		coordinator = HomeCoordinatorMock()
		sut = HomeViewModelImpl(model: model, coordinator: coordinator)
		sut.view = view
		super.setUp()
	}

	override func tearDown() {
		sut = nil
		view = nil
		model = nil
		coordinator = nil
		super.tearDown()
	}

	// MARK: - Test

	func test_fetchDatas_should_present_error_if_city_id_is_nil() {
		// Given
		sut.cityId = nil

		// When
		sut.fetchDatas()

		// Then
		XCTAssertTrue(view.updateErrorCalled)
		XCTAssertEqual(view.updateErrorViewModel?.actionTitle, "alert.action.title".localized())
		XCTAssertEqual(view.updateErrorViewModel?.message, "alert.message".localized())
		XCTAssertEqual(view.updateErrorViewModel?.title, "alert.title".localized())
	}

	func test_fetchDatas_should_present_error_if_receive_result_error() {
		// Given
		let modelSpy = HomeModelFailureSpy()
		sut = HomeViewModelImpl(model: modelSpy, coordinator: coordinator)
		sut.view = view
		
		sut.cityId = 1234

		// When
		sut.fetchDatas()

		// Then
		XCTAssertTrue(modelSpy.fetchInfosCalled)
		XCTAssertTrue(view.updateErrorCalled)
		XCTAssertEqual(view.updateErrorViewModel?.actionTitle, "alert.action.title".localized())
		XCTAssertEqual(view.updateErrorViewModel?.message, "alert.message".localized())
		XCTAssertEqual(view.updateErrorViewModel?.title, "alert.title".localized())
	}

	func test_fetchDatas_should_update_view_if_receive_result_success() {
		// Given
		let modelSpy = model as! HomeModelSuccessSpy
		sut.view = view

		sut.cityId = 1234

		let mainExpectation = expectation(description: "main")
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			mainExpectation.fulfill()
		}

		let expectedName = "Paris"
		let expectDescription = "Ici c'est Paris"
		let expectedCurrentTemperature = "10°"
		let expectedDayName = "home.today".localized()
		let expectedDayMax = "30"
		let expectedDayMin = "0"
		let expectedDayImageUrl = "http://icon.com"

		// When
		sut.fetchDatas()

		// Then
		waitForExpectations(timeout: 0.2) { _ in
			XCTAssertTrue(modelSpy.fetchInfosCalled)
			XCTAssertTrue(self.view.updateCalled)
			XCTAssertEqual(self.view.updateViewModel?.cityId, self.sut.cityId)
			XCTAssertEqual(self.view.updateViewModel?.currentTemperature, expectedCurrentTemperature)
			XCTAssertEqual(self.view.updateViewModel?.days.first?.name, expectedDayName)
			XCTAssertEqual(self.view.updateViewModel?.days.first?.max,expectedDayMax)
			XCTAssertEqual(self.view.updateViewModel?.days.first?.min, expectedDayMin)
			XCTAssertEqual(self.view.updateViewModel?.days.first?.imageUrl, expectedDayImageUrl)
			XCTAssertEqual(self.view.updateViewModel?.description, expectDescription)
			XCTAssertEqual(self.view.updateViewModel?.name, expectedName)
		}
	}

	func test_didTapDetail_should_ask_view_to_update_with_error_if_city_id_is_nil() {
		// Given
		sut.cityId = nil

		// When
		sut.didTapDetail()

		// Then
		XCTAssertTrue(view.updateErrorCalled)
		XCTAssertEqual(view.updateErrorViewModel?.actionTitle, "alert.action.title".localized())
		XCTAssertEqual(view.updateErrorViewModel?.message, "alert.message".localized())
		XCTAssertEqual(view.updateErrorViewModel?.title, "alert.title".localized())
	}

	func test_didTapDetail_should_ask_coordinator_to_start_details() {
		// Given
		sut.cityId = 1234

		// When
		sut.didTapDetail()

		let expectedValue = 1234

		// Then
		XCTAssertTrue(coordinator.startDetailsCalled)
		XCTAssertEqual(coordinator.startDetailsCityId, expectedValue)
	}
}
