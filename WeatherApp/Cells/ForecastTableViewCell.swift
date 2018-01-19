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
    
    func configure(with viewModel: ForecastTableViewCellViewModel) {
        
        dayLabel.text = viewModel.dayLabelText()
        degreesLabel.text = viewModel.degreesLabelText()
        weatherImageView.image = viewModel.forecastImage()
    }
    
}
