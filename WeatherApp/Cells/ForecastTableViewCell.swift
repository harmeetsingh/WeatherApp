//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    // MARK: Configuration
    
    func configure(with forecast: Forecast) {
        
        if let date = forecast.date {
            
            dayLabel.text = date.dayOfWeek()
        }
        
        if let degrees = forecast.dayTemperature {
            
            degreesLabel.text = "\(degrees)°C"
        }
        
        if let image = forecast.type?.image {
            
            weatherImageView.image = image
        }
    }
    
}
