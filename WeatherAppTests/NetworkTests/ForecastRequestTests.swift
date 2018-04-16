//
//  ForecastRequestTests.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import XCTest

class ForecastRequestTests: XCTestCase {
    
    // MARK: Properties
    
    var forecastRequest: ForecastRequest?
    
    // MARK: Lifecycle
    
    override func setUp() {
        
        forecastRequest = ForecastRequest(cityID: 1234567, appID: "a78f88499f4ad371151071ae9cf48f00")
    }
    
    override func tearDown() {
        
        forecastRequest = nil
    }
    
    func testForecastRequest_NotNil() {
        
        XCTAssertNotNil(forecastRequest, "forecastRequest mshould not be nil")
    }
}

// MARK: domain

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.domain not nil
    
    func testForecast_Domain_CorrectValue() {
        
        let domain = forecastRequest?.domain
        let expectedDomain = "https://api.openweathermap.org"
        
        XCTAssertEqual(domain, expectedDomain, "domain and expectedDomain should be the same value")
    }
}

// MARK: endpoint

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.endpoint not nil
    
    func testForecastRequest_Endpoint_CorrectValue() {
        
        let endpoint = forecastRequest?.endpoint
        let expectedEndpoint = "/data/2.5/forecast/daily"
        
        XCTAssertEqual(endpoint, expectedEndpoint, "endpoint and expectedEndpoint should be the same value")
    }
}

// MARK: method

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.method not nil
    
    func testForecastRequest_Method_CorrectValue() {
        
        let method = forecastRequest?.method.rawValue
        let expectedMethod = "GET"
        
        XCTAssertEqual(method, expectedMethod, "method and expectedMethod should be the same value")
    }
}

// MARK: query

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.query not nil
    
    func testForecastRequest_Query_CorrectValue() {
        
        let query = forecastRequest?.query
        let expectedQuery = "?id=1234567&appid=a78f88499f4ad371151071ae9cf48f00&units=metric"
        
        XCTAssertEqual(query, expectedQuery, "query and expectedQuery should be the same value")
    }
}

// MARK: request

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.request nil when url is nil
    // TODO: Test forecastRequest?.request not nil
    
    func testForecastRequest_Request_URLCorrectValue() {
        
        let requestURLString = forecastRequest?.request?.url?.absoluteString
        let expectedURLString = "https://api.openweathermap.org/data/2.5/forecast/daily?id=1234567&appid=a78f88499f4ad371151071ae9cf48f00&units=metric"
        
        XCTAssertEqual(requestURLString, expectedURLString, "requestURLString and expectedURLString should be the same value")
    }
    
    // TODO: Test forecastRequest?.request.httpMethod not nil
    
    func testForecastRequest_Request_HTTPMethodCorrectValue() {
        
        let httpMethod = forecastRequest?.request?.httpMethod
        let expectedHTTPMethod = "GET"
        
        XCTAssertEqual(httpMethod, expectedHTTPMethod, "httpMethod and expectedHTTPMethod should be the same value")
    }
}
