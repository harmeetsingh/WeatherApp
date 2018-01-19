//
//  ForecastTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 19/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation
import UIKit

struct ForecastTableViewCellViewModel {
    
    // MARK: Properties
    
    let forecast: Forecast
    
    // MARK: Instantiation
    
    init(with forecast: Forecast) {
        
        self.forecast = forecast
    }
    
    // MARK: Text
    
    func dayLabelText() -> String? {
        
        if let date = forecast.date {

            return date.dayOfWeek()
        }
        
        return nil
    }
    
    func degreesLabelText() -> String? {
        
        if let degrees = forecast.dayTemperature {

            return "\(degrees)°C"
        }
        
        return nil
    }
    
    // MARK: Image
    
    func forecastImage() -> UIImage? {
        
        if let image = forecast.type?.image {

            return image
        }
        
        return nil
    }
}
