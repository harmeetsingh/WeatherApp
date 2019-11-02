//
//  MockForecastViewController.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 15/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation
import XCTest

class MockForecastViewController: ForecastViewController {
    
    // MARK: - Properties
    
    var forecastRequestDidFail = false
    var forecastRequestDidSucceed = false
    var expectation: XCTestExpectation?
    
    // MARK: - ForecastViewControllerViewModelDelegate
    
    override func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecasts: [Forecast]) {
        
        forecastRequestDidSucceed = true
        expectation?.fulfill()
    }
    
    override func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecastRequestError: Error) {
        
        forecastRequestDidFail = true
        expectation?.fulfill()
    }
}
