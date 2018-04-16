//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

protocol WeatherServiceProtocol {
    
    typealias ForecastCompletion = (_ forecasts: [Forecast]?, _ error: Error?) -> Void
    
    // MARK: Methods
    
    func fetchForecast(for cityID: Int, completion: @escaping ForecastCompletion)
}
