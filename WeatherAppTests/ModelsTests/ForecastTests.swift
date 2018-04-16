//
//  ForecastTests.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import XCTest

class ForecastTests: XCTestCase {
    
    // MARK: Properties
    
    var forecast: Forecast?
    
    // MARK: Lifecycle
    
    override func setUp() {

        shouldUseValidForecastJSON(true)
    }
    
    override func tearDown() {
        
        forecast = nil
    }
    
    func testForecast_NotNil() {
        
        XCTAssertNotNil(forecast, "forecast should not be nil")
    }
    
    func shouldUseValidForecastJSON(_ useValidForecastJSON: Bool) {

        let fileName = useValidForecastJSON ? "ForecastRequest_ValidForecastItem" : "ForecastRequest_InvalidForecastItem"
        
        guard let data = data(for: fileName, className: ForecastTests.self) else {

            return XCTFail("\(fileName) file not found")
        }
        
        forecast = try? JSONDecoder().decode(Forecast.self, from: data)
    }
}

// MARK: date

extension ForecastTests {
    
    func testInit_InvalidJSON_DateNil() {
        
        shouldUseValidForecastJSON(false)
        XCTAssertNil(forecast?.date, "forecast date should be nil")
    }
    
    func testInit_ValidJSON_DateNotNil() {
        
        XCTAssertNotNil(forecast?.date, "forecast date should not be nil")
    }
    
    func testInit_ValidJSON_DateCorrectValue() {
        
        XCTAssertEqual(forecast?.date?.timeIntervalSince1970, 1515931200, "forecast date should be 1515931200")
    }
}

// MARK: title

extension ForecastTests {
    
    func testInit_InvalidJSON_TitleNil() {
        
        shouldUseValidForecastJSON(false)
        XCTAssertNil(forecast?.title, "forecast title should be nil")
    }
    
    func testInit_ValidJSON_TitleNotNil() {
        
        XCTAssertNotNil(forecast?.title, "forecast title should not be nil")
    }
    
    func testInit_ValidJSON_TitleCorrectValue() {
        
        XCTAssertEqual(forecast?.title, "Clear", "forecast title should be Clear")
    }
}

// MARK: dayTemperature

extension ForecastTests {
    
    func testInit_InvalidJSON_DayTemperatureNil() {
        
        shouldUseValidForecastJSON(false)
        XCTAssertNil(forecast?.dayTemperature, "forecast dayTemperature should be nil")
    }
    
    func testInit_ValidJSON_DayTemperatureNotNil() {
        
        XCTAssertNotNil(forecast?.dayTemperature, "forecast dayTemperature should not be nil")
    }
    
    func testInit_ValidJSON_DayTemperatureCorrectValue() {
        
        XCTAssertEqual(forecast?.dayTemperature, 9, "forecast dayTemperature should be 9")
    }
}

// MARK: nightTemperature

extension ForecastTests {
    
    func testInit_InvalidJSON_NightTemperatureNil() {
        
        shouldUseValidForecastJSON(false)
        XCTAssertNil(forecast?.nightTemperature, "forecast nightTemperature should be nil")
    }
    
    func testInit_ValidJSON_NightTemperatureNotNil() {
        
        XCTAssertNotNil(forecast?.nightTemperature, "forecast nightTemperature should not be nil")
    }
    
    func testInit_ValidJSON_NightTemperatureCorrectValue() {
        
        XCTAssertEqual(forecast?.nightTemperature, 2, "forecast nightTemperature should be 2")
    }
}

// MARK: type

extension ForecastTests {
    
    func testInit_InvalidJSON_TypeCorrectValue() {
        
        shouldUseValidForecastJSON(false)
        XCTAssertEqual(forecast?.type, ForecastType.unknown, "forecast type should be unknown")
    }
    
    func testInit_ValidJSON_TypeValue() {
        
        XCTAssertEqual(forecast?.type, ForecastType.sunny, "forecast type should be 2")
    }
}
