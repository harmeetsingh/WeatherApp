//
//  WeatherServiceTests.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 13/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import XCTest
import SuperSession

class WeatherServiceTests: XCTestCase {
    
    // MARK: Properties
    
    var weatherService: WeatherService?
    let urlSession = SuperSession()
    let cityID = 12345
    
    // MARK: Lifecycle
    
    override func setUp() {
    
        weatherService = WeatherService(urlSession: urlSession, appID: "123456789")
    }
    
    override func tearDown() {
        
        weatherService = nil
    }
    
    func testWeatherService_NotNil() {
        
        XCTAssertNotNil(weatherService, "weatherService mshould not be nil")
    }
}

// MARK: fetchForecast - validation

extension WeatherServiceTests {
    
    func testFetchForecast_CityIDNegativeValue_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_CityIDNegativeValue_ErrorCorrectValue")
        
        weatherService?.fetchForecast(for: -100, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            let weatherServiceError = error as? WeatherServiceError
            XCTAssertEqual(weatherServiceError, WeatherServiceError.cityIDInvalidValue, "weatherServiceError should be cityIDInvalidValue")
            
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchForecast_CityIDInvalidLength_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_CityIDInvalidLength_ErrorCorrectValue")
        
        weatherService?.fetchForecast(for: -100, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            let weatherServiceError = error as? WeatherServiceError
            XCTAssertEqual(weatherServiceError, WeatherServiceError.cityIDInvalidValue, "weatherServiceError should be cityIDInvalidValue")
            
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchForecast_RequestNil_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_CityIDInvalidLength_ErrorCorrectValue")
        
        weatherService?.fetchForecast(for: -100, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            let weatherServiceError = error as? WeatherServiceError
            XCTAssertEqual(weatherServiceError, WeatherServiceError.cityIDInvalidValue, "weatherServiceError should be cityIDInvalidValue")
            
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
    
    
//
//// MARK: fetchForecast - unsuccessful
//
//extension WeatherServiceTests {
//    
//    // TODO: Test request returned error, error not nil
//    
//    func testFetchForecast_ErrorOccured_ErrorCorrectValue() {
//        
//        let testExpectation = expectation(description: "testFetchForecast_ErrorOccured_ErrorCorrectValue")
//        
//        let randomError = MockError.randomError
//        mockURLSession.stubDataTask(withError: randomError)
//        
//        weatherService?.fetchForecast(for: "London", countryCode: "GB", completion: { (forecasts: [Forecast]?, error: Error?) in
//            
//            let mockError = error as? MockError
//            XCTAssertEqual(mockError, MockError.randomError, "mockError should be randomError")
//            
//            testExpectation.fulfill()
//        })
//        
//        waitForExpectations(timeout: 0.1, handler: nil)
//    }
//    
//    // TODO: Test statusCode invalid, error not nil
//    
//    func testFetchForecast_StatusCodeInvalid_ErrorCorrectValue() {
//        
//        let testExpectation = expectation(description: "testFetchForecast_StatusCodeInvalid_ErrorCorrectValue")
//        
//        let mockResponse = mockURLResponse(withStatusCode: 404)
//        urlSession.stubDataTask(withResponse: mockResponse)
//        
//        weatherService?.fetchForecast(for: "London", countryCode: "GB", completion: { (forecasts: [Forecast]?, error: Error?) in
//            
//            let weatherServiceError = error as? WeatherServiceError
//            XCTAssertEqual(weatherServiceError, WeatherServiceError.requestFailed, "weatherServiceError should be requestFailed")
//            
//            testExpectation.fulfill()
//        })
//        
//        waitForExpectations(timeout: 0.1, handler: nil)
//    }
//}
//
//// MARK: fetchForecast - successful
//
//extension WeatherServiceTests {
//    
//    // TODO: Test request returned invalid data, error not nil
//    // TODO: Test request returned invalid data, error correct value
//    // TODO: Test request returned valid data, error nil
//    
//    func testFetchForecast_ValidData_ForecastsNotNil() {
//        
//        let testExpectation = expectation(description: "testFetchForecast_ValidData_ForecastsNotNil")
//        
//        let mockData = data(fromFile: "Valid_AllForecasts")
//        let mockResponse = mockURLResponse(withStatusCode: 200)
//        mockURLSession.stubDataTask(with: mockData, response: mockResponse, error: nil)
//        
//        weatherService?.fetchForecast(for: "London", countryCode: "GB", completion: { (forecasts: [Forecast]?, error: Error?) in
//            
//            XCTAssertNotNil(forecasts, "forecasts should not be nil")
//            testExpectation.fulfill()
//        })
//        
//        waitForExpectations(timeout: 0.1, handler: nil)
//    }
//    
//    func testFetchForecast_ValidData_ForecastsCorrectCount() {
//        
//        let testExpectation = expectation(description: "testFetchForecast_ValidData_ForecastsNotNil")
//        
//        let mockData = data(fromFile: "Valid_AllForecasts")
//        let mockResponse = mockURLResponse(withStatusCode: 200)
//        mockURLSession.stubDataTask(with: mockData, response: mockResponse, error: nil)
//        
//        weatherService?.fetchForecast(for: "London", countryCode: "GB", completion: { (forecasts: [Forecast]?, error: Error?) in
//            
//            XCTAssertNotNil(forecasts, "forecasts should not be nil")
//            testExpectation.fulfill()
//        })
//        
//        waitForExpectations(timeout: 0.1, handler: nil)
//    }
//}
//
//// MARK: Helpers
//
//extension WeatherServiceTests {
//    
//    func mockURLResponse(withStatusCode statusCode: Int) -> URLResponse? {
//        
//        if let url = URL(string: "http://api.openweathermap.org") {
//            
//            return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "1.1", headerFields: nil)
//        }
//        
//        return nil
//    }
//    
//    enum MockError: Error {
//        case randomError
//    }
//}

