//
//  DailyForecastImageType.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 11/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

enum ForecastType {
    
    case sunny
    case sunnyCloudy
    case cloudy
    case darkClouds
    case rainShower
    case rain
    case thunderstorm
    case snow
    case mist
    case unknown
    
    // TODO: Use generics to avoid duplicate switch statements
    
    var image: UIImage? {
        
        switch self {
            
        case .sunny:
            
            return UIImage(named: "sunny")
            
        case .sunnyCloudy:
            
            return UIImage(named: "sunny-cloudy")
            
        case .cloudy:
            
            return UIImage(named: "cloudy")
        
        case .darkClouds:
            
            return UIImage(named: "dark-clouds")
            
        case .rainShower:
            
            return UIImage(named: "rain-shower")
            
        case .rain:
            
            return UIImage(named: "rain")
            
        case .thunderstorm:
            
            return UIImage(named: "thunderstorm")

        case .snow:
            
            return UIImage(named: "snow")
            
        case .mist:
            
            return UIImage(named: "mist")
        
        default:
            
            return nil;
        }
    }
    
    static func forecastTypeValue(for json: JSON) -> ForecastType {
        
        let weatherJSON = json[Constants.ParsingKeys.WeatherKey].array?.first
        
        guard let icon = weatherJSON?[Constants.ParsingKeys.IconKey].string else {
            
            return .unknown
        }
        
        switch icon {
            
        case "01d", "01n":
            
            return .sunny
            
        case "02d", "02n":
            
            return .sunnyCloudy
            
        case "03d", "03n":
            
            return .cloudy
            
        case "04d", "04n":
            
            return .darkClouds
            
        case "09d", "09n":
            
            return .rainShower
            
        case "10d", "10n":
            
            return .rain
            
        case "11d", "11n":
            
            return .thunderstorm
            
        case "13d", "13n":
            
            return .snow
            
        case "50d", "50n":
            
            return .mist
            
        default:
            
            return .unknown
        }
    }
}
