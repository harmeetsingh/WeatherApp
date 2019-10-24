//
//  ForecastViewControllerViewModelDelegate.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

protocol ForecastViewControllerViewModelDelegate {
    
    func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecasts: [Forecast])
    func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecastRequestError: Error)
}
