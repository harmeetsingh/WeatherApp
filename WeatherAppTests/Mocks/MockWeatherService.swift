//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 15/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

class MockWeatherService: WeatherServiceProtocol {
    
    // MARK: Properties
    
    var responseError: Error?
    var responseForecasts: [Forecast] = []
    
    func fetchForecast(for cityID: Int, completion: @escaping WeatherServiceProtocol.ForecastCompletion) {
        
        completion(responseForecasts, responseError)
    }
}
