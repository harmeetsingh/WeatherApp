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
        
        weatherService?.fetchForecast(for: 1000, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            let weatherServiceError = error as? WeatherServiceError
            XCTAssertEqual(weatherServiceError, WeatherServiceError.cityIDInvalidValue, "weatherServiceError should be cityIDInvalidValue")
            
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

// MARK: fetchForecast - unsuccessful

extension WeatherServiceTests {
    
    func testFetchForecast_ErrorOccured_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_ErrorOccured_ErrorCorrectValue")
        
        let randomError = MockError.randomError
        urlSession.stubDataTask(withError: randomError)
        
        weatherService?.fetchForecast(for: 1234567, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            guard let weatherServiceError = error as? MockError else {
                
                return XCTFail("Expected error to be type MockError")
            }
            
            XCTAssertEqual(weatherServiceError, MockError.randomError, "weatherServiceError should be randomError")
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    // TODO: Test statusCode invalid, error not nil

    func testFetchForecast_ResponseStatusCodeInvalid_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_ResponseStatusCodeInvalid_ErrorCorrectValue")
        
        let mockResponse = urlResponse(with: 404)
        urlSession.stubDataTask(withResponse: mockResponse)
        
        weatherService?.fetchForecast(for: 1234567, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            guard let weatherServiceError = error as? WeatherServiceError else {
                
                return XCTFail("Expected error to be type WeatherServiceError")
            }
             
            XCTAssertEqual(weatherServiceError, WeatherServiceError.requestFailed, "weatherServiceError should be requestFailed")
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchForecast_ResponseDataNil_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_ResponseDataNil_ErrorCorrectValue")
        
        let mockResponse = urlResponse(with: 200)
        urlSession.stubDataTask(with: nil, response: mockResponse, error: nil)
        
        weatherService?.fetchForecast(for: 1234567, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            guard let weatherServiceError = error as? WeatherServiceError else {
                
                return XCTFail("Expected error to be type WeatherServiceError")
            }
                
            XCTAssertEqual(weatherServiceError, WeatherServiceError.responseDataNil, "weatherServiceError should be responseDataNil")
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchForecast_ResponseDataInvalidJSON_ErrorCorrectValue() {
        
        let testExpectation = expectation(description: "testFetchForecast_ResponseDataInvalidJSON_ErrorCorrectValue")
        
        let mockResponse = urlResponse(with: 200)
        let mockData = data(for: "ForecastRequest_InvalidResponse")
        urlSession.stubDataTask(with: mockData, response: mockResponse, error: nil)
        
        weatherService?.fetchForecast(for: 1234567, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            guard let error = error as NSError? else {
                
                return XCTFail("Expected error to be type NSError")
            }
                
            XCTAssertEqual(error.code, 3840, "error code should be 3840")
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

// MARK: fetchForecast - successful

extension WeatherServiceTests {

    func testFetchForecast_ResponseDataValid_ForecastsNotNil() {

        let testExpectation = expectation(description: "testFetchForecast_ResponseDataValid_ForecastsNotNil")
        
        let mockResponse = urlResponse(with: 200)
        let mockData = data(for: "ForecastRequest_ValidResposne")
        urlSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        weatherService?.fetchForecast(for: 1234567, completion: { (forecasts: [Forecast]?, error: Error?) in

            XCTAssertNotNil(forecasts, "forecasts should not be nil")
            testExpectation.fulfill()
        })

        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testFetchForecast_ResponseDataValid_ForecastsCorrectCount() {
        
        let testExpectation = expectation(description: "testFetchForecast_ResponseDataValid_ForecastsCorrectCount")
        
        let mockResponse = urlResponse(with: 200)
        let mockData = data(for: "ForecastRequest_ValidResposne")
        urlSession.stubDataTask(with: mockData, response: mockResponse, error: nil)
        
        weatherService?.fetchForecast(for: 1234567, completion: { (forecasts: [Forecast]?, error: Error?) in
            
            XCTAssertEqual(forecasts?.count, 7, "forecasts count should be 7")
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

//// MARK: Helpers

extension WeatherServiceTests {
    
    func urlResponse(with statusCode: Int) -> URLResponse? {
        
        if let url = URL(string: "http://api.openweathermap.org") {
            
            return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "1.1", headerFields: nil)
        }
        
        return nil
    }
    
    func data(for fileName: String) -> Data? {
        
        if let url = Bundle(for: WeatherServiceTests.self).url(forResource: fileName, withExtension: "json") {
            
            return try? Data(contentsOf: url)
        }
        
        return nil
    }
    
    enum MockError: Error {
        
        case randomError
    }
}

