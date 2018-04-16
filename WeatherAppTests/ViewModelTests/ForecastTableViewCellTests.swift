//
//  ForecastTableViewCellTests.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 19/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//k

import XCTest

class ForecastTableViewCellTests: XCTestCase {
    
    // MARK: Properties
    
    var forecastCellViewModel: ForecastTableViewCellViewModel?
    
    // MARK: Lifecycle
    
    override func setUp() {

        let fileName = "ForecastRequest_ValidForecastItem"
        
        guard let data = data(for: fileName, className: ForecastTableViewCellTests.self) else {
            
            return XCTFail("\(fileName) file not found")
        }
        
        if let forecast = try? JSONDecoder().decode(Forecast.self, from: data) {
         
            forecastCellViewModel = ForecastTableViewCellViewModel(with: forecast)
        }
    }
    
    override func tearDown() {
        
        forecastCellViewModel = nil
    }
    
    func testForecastCellViewModel_NotNil() {
        
        XCTAssertNotNil(forecastCellViewModel, "forecastCellViewModel should be nil")
    }
}
