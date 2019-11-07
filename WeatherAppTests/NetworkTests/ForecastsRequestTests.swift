//
//  ForecastRequestTests.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ForecastRequestTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: ForecastsRequest?
    
    // MARK: - Lifecycle
    
    override func setUp() {
        
        sut = ForecastsRequest(cityID: 1234567, appID: "a78f88499f4ad371151071ae9cf48f00")
    }
    
    override func tearDown() {
        
        sut = nil
    }
    
    func testForecastRequest_NotNil() {
        
        XCTAssertNotNil(sut, "forecastRequest mshould not be nil")
    }
}

// MARK: - domain

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.domain not nil
    
    func testForecast_Domain_CorrectValue() {
        
        let domain = sut?.domain
        let expectedDomain = "https://api.openweathermap.org"
        
        XCTAssertEqual(domain, expectedDomain, "domain and expectedDomain should be the same value")
    }
}

// MARK: - endpoint

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.endpoint not nil
    
    func testForecastRequest_Endpoint_CorrectValue() {
        
        let endpoint = sut?.endpoint
        let expectedEndpoint = "/data/2.5/forecast/daily"
        
        XCTAssertEqual(endpoint, expectedEndpoint, "endpoint and expectedEndpoint should be the same value")
    }
}

// MARK: - method

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.method not nil
    
    func testForecastRequest_Method_CorrectValue() {
        
        let method = sut?.method.rawValue
        let expectedMethod = "GET"
        
        XCTAssertEqual(method, expectedMethod, "method and expectedMethod should be the same value")
    }
}

// MARK: - query

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.query not nil
    
    func testForecastRequest_Query_CorrectValue() {
        
        let query = sut?.query
        let expectedQuery = "?id=1234567&appid=a78f88499f4ad371151071ae9cf48f00&units=metric"
        
//        XCTAssertEqual(query, expectedQuery, "query and expectedQuery should be the same value")
        XCTFail()
    }
}

// MARK: - request

extension ForecastRequestTests {
    
    // TODO: Test forecastRequest?.request nil when url is nil
    // TODO: Test forecastRequest?.request not nil
    
    func testForecastRequest_Request_URLCorrectValue() {
        
        let requestURLString = try? sut?.urlRequest(with: "", appID: "").url?.absoluteString
        let expectedURLString = "https://api.openweathermap.org/data/2.5/forecast/daily?id=1234567&appid=a78f88499f4ad371151071ae9cf48f00&units=metric"
        
        XCTAssertEqual(requestURLString, expectedURLString, "requestURLString and expectedURLString should be the same value")
    }
    
    // TODO: Test forecastRequest?.request.httpMethod not nil
    
    func testForecastRequest_Request_HTTPMethodCorrectValue() {
        
        let httpMethod = sut?.method.rawValue
        let expectedHTTPMethod = "GET"
        
        XCTAssertEqual(httpMethod, expectedHTTPMethod, "httpMethod and expectedHTTPMethod should be the same value")
    }
}
