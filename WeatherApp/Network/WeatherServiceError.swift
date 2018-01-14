//
//  WeatherServiceError.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

enum WeatherServiceError: Error {
    
    case cityIDInvalidValue
    
    case requestFailed
    
    case nilForecastRequest
    case nilResponseData
}
