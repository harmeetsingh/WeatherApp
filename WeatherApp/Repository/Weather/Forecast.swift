//
//  Forecast.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    
    // MARK: Properties
    
    let date: Date
    let title: String
    let dayTemperature: Int
    let nightTemperature: Int
    let type: ForecastType
    
    // MARK: CodingKeys
    
    enum ForecastCodingKeys: String, CodingKey {
        
        case date = "dt"
        case weather
        case temperature = "temp"
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        
        case title = "main"
        case icon
    }

    enum TemperatureCodingKeys: String, CodingKey {
        
        case dayTemperature = "day"
        case nightTemperature = "night"
    }
    
    // MARK: Instantiation
    
    init(from decoder: Decoder) throws {
        
        let forecastContainer = try decoder.container(keyedBy: ForecastCodingKeys.self)
        date = try forecastContainer.decode(Date.self, forKey: .date)
        
        var weatherArrayContainer = try forecastContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weatherArrayContainer.nestedContainer(keyedBy: WeatherCodingKeys.self)
        title = try weatherContainer.decode(String.self, forKey: .title)
        
        let iconName = try weatherContainer.decodeIfPresent(String.self, forKey: .icon)
        type = ForecastType.type(from: iconName)
        
        let tempreatureContainer = try forecastContainer.nestedContainer(keyedBy: TemperatureCodingKeys.self, forKey: .temperature)
        let dayTemperatureDoubleValue = try tempreatureContainer.decodeIfPresent(Double.self, forKey: .dayTemperature)
        let nightTemperatureDoubleValue = try tempreatureContainer.decodeIfPresent(Double.self, forKey: .nightTemperature)
        
        dayTemperature = Int(round(dayTemperatureDoubleValue ?? 0))
        nightTemperature = Int(round(nightTemperatureDoubleValue ?? 0))
    }
}

// MARK: CustomStringConvertible

extension Forecast: CustomStringConvertible {
    
    var description: String {
        
        return "Date: \(String(describing: date)) \n Title: \(String(describing: title)) \n Day Temperature \(String(describing: dayTemperature)) \n Night Temperature \(String(describing: nightTemperature)) \n Type: \(String(describing: type))"
    }
}
