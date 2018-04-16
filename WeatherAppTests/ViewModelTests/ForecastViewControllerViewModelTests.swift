//
//  ForecastViewControllerViewModelTests.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 15/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import XCTest

class ForecastViewControllerViewModelTests: XCTestCase {
    
    // MARK: Properties
    
    let mockForecastViewController = MockForecastViewController()
    var mockWeatherService: MockWeatherService!
    var forecastViewModel: ForecastViewControllerViewModel?
    
    // MARK: Lifecycle
    
    override func setUp() {
        
        mockWeatherService = MockWeatherService()
        forecastViewModel = ForecastViewControllerViewModel(delegate: mockForecastViewController, weatherService: mockWeatherService)
    }
    
    override func tearDown() {
        
        forecastViewModel = nil
    }
    
    func testForecastViewModel_NotNil() {
        
        XCTAssertNotNil(forecastViewModel, "forecastViewModel should not be nil")
    }
}

// MARK: init

extension ForecastViewControllerViewModelTests {
    
    func testInit_DelegateNotNil() {
        
        let delegate = forecastViewModel?.delegate
        XCTAssertNotNil(delegate, "delegate should not be nil")
    }
    
    func testInit_WeatherServiceNotNil() {
        
        let weatherService = forecastViewModel?.weatherService
        XCTAssertNotNil(weatherService, "weatherService should not be nil")
    }
}

// MARK: delegate

extension ForecastViewControllerViewModelTests {

    func testDelegate_ForecastRequestFailed_ForecastRequestErrorMethodCalled() {

        let testExpectation = expectation(description: "testDelegate_ForecastRequestFailed_ForecastRequestErrorMethodCalled")
        mockForecastViewController.expectation = testExpectation
        mockWeatherService.responseError = MockError.randomError

        forecastViewModel?.fetchForecast(for: 2648110)

        waitForExpectations(timeout: 0.2) { (error: Error?) in

            if let error = error {

                return XCTFail("waitForExpectations error: \(error)")
            }
            
            XCTAssert(self.mockForecastViewController.forecastRequestDidFail, "forecastRequestDidFail should be true")
        }
    }
    
    func testDelegate_ForecastRequestSuccessful_ForecastsMethodCalled() {
        
        let testExpectation = expectation(description: "testDelegate_ForecastRequestSuccessful_ForecastsMethodCalled")
        mockForecastViewController.expectation = testExpectation
        mockWeatherService.responseForecasts = []
        
        forecastViewModel?.fetchForecast(for: 2648110)
        
        waitForExpectations(timeout: 0.2) { (error: Error?) in
            
            if let error = error {
                
                return XCTFail("waitForExpectations errord: \(error)")
            }
            
            XCTAssert(self.mockForecastViewController.forecastRequestDidSucceed, "forecastRequestDidSucceed should be true")
        }
    }
}

// MARK: UI

extension ForecastViewControllerViewModelTests {
    
    func testDayLabelTitle_ValidForecast_DayLabelValueNotNil() {
        
        configureForecasts()
        let dayText = forecastViewModel?.dayLabelTitle()
        
        XCTAssertNotNil(dayText, "dayText should not be nil")
    }
    
    func testDayLabelTitle_ValidForecast_DayLabelCorrectValue() {
        
        configureForecasts()
        let dayText = forecastViewModel?.dayLabelTitle()
        
        XCTAssertEqual(dayText, "Thursday", "dayText should be Thursday")
    }
    
    func testDegreesLabelTitle_InvalidForecast_DegreesLabelCorrectValue() {
        
        let degreesText = forecastViewModel?.degreesLabelTitle()
        XCTAssertEqual(degreesText, "", "degreesText should be empty")
    }
    
    func testDegreesLabelTitle_ValidForecast_DegreesLabelNotNil() {
        
        configureForecasts()
        let degreesText = forecastViewModel?.degreesLabelTitle()
        
        XCTAssertNotNil(degreesText, "degreesText should not be nil")
    }
    
    func testDegreesLabelTitle_ValidForecast_DegreesCorrectValue() {
        
        configureForecasts()
        let degreesText = forecastViewModel?.degreesLabelTitle()
        
        XCTAssertEqual(degreesText, "9°C", "degreesText should be 9°C")
    }
}

// MARK: UITableView

extension ForecastViewControllerViewModelTests {
    
    func testNumberOfRows_ValidForecasts_CountCorrectValue() {
        
        configureForecasts()
        configureForecasts()
        
        let numberOfRows = forecastViewModel?.numberOfRows(in: 0)
        
        XCTAssertEqual(numberOfRows, 1, "numberOfRows should be 1")
    }
    
    func testNumberOfRows_InvalidForecasts_CountCorrectValue() {
        
        let numberOfRows = forecastViewModel?.numberOfRows(in: 0)
        
        XCTAssertEqual(numberOfRows, -1, "numberOfRows should be -1")
    }

    func testCellForRow_InvalidForecasts_CellCorrectClass() {
        
        configureForecasts()
        configureForecasts()
        
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = forecastViewModel?.tableView(tableView, cellForRowAt: indexPath).classForCoder == UITableViewCell.self
        
        XCTAssert(cell, "cell should be of type UITableView")
    }

}

// MARK: Helpers

extension ForecastViewControllerViewModelTests {
    
    func configureForecasts() {
        
        guard let data = data(for: "ForecastRequest_ValidForecastItem", className: ForecastTests.self) else {
            
            return XCTFail("ForecastRequest_ValidForecastItem file not found")
        }
        
        if let forecast = try? JSONDecoder().decode(Forecast.self, from: data) {
         
            forecastViewModel?.forecasts.append(forecast)
        }
    }
}
