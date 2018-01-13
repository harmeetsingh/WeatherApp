//
//  Forecast.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Forecast {
    
    // MARK: Properties
    
    let date: Date?
    let title: String?
    let dayTemperature: Int?
    let nightTemperature: Int?
    let type: ForecastType?
    
    // MARK: Instantiation
    
    init(with json: JSON) {
        
        date = Forecast.date(from: json)
        title = Forecast.title(from: json)
        dayTemperature = Forecast.temperature(fromKey: Constants.ParsingKeys.DayKey, json: json)
        nightTemperature = Forecast.temperature(fromKey: Constants.ParsingKeys.NightKey, json: json)
        type = ForecastType.forecastTypeValue(for: json)
    }
}

// MARK: CustomStringConvertible

extension Forecast: CustomStringConvertible {
    
    var description: String {
        
        return "Date: \(String(describing: date)) \n Title: \(String(describing: title)) \n Day Temperature \(String(describing: dayTemperature)) \n Night Temperature \(String(describing: nightTemperature)) \n Type: \(String(describing: type))"
    }
}

// MARK: Helpers

fileprivate extension Forecast {
    
    static func date(from json: JSON) -> Date? {
        
        if let epochTime = json[Constants.ParsingKeys.DateKey].double {
            
            return Date(timeIntervalSince1970: epochTime)
        }
        
        return nil
    }
    
    static func title(from json: JSON) -> String? {
    
        if let weather = json[Constants.ParsingKeys.WeatherKey].array?.first, let title = weather[Constants.ParsingKeys.MainKey].string {
            
            return title
        }
        
        return nil
    }
    
    static func temperature(fromKey key: String, json: JSON) -> Int? {
        
        if let temperatureJSON = json[Constants.ParsingKeys.TemperatureKey].dictionary {
            
            guard let tempreature = temperatureJSON[key]?.double else {
                
                return 0
            }
            
            return Int(round(tempreature))
        }
        
        return nil
    }
}
