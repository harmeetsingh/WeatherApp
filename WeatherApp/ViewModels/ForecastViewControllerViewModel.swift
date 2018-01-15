//
//  ForecastViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewControllerViewModel {
    
    // MARK: Properties
    
    var weatherService: WeatherServiceProtocol?
    var forecasts: [Forecast] = []
    var delegate: ForecastViewController?
    
    // MARK: Instantiation

    init(delegate: ForecastViewController, weatherService: WeatherServiceProtocol = WeatherService(urlSession: URLSession.shared)) {
        
        self.delegate = delegate
        self.weatherService = weatherService
    }
}

// MARK: Forecast request

extension ForecastViewControllerViewModel {
    
    func fetchForecast(for cityID: Int) {
        
        weatherService?.fetchForecast(for:cityID) { [weak self] (forecasts: [Forecast]?, error: Error?) in
            
            if let error = error {
                
                self?.delegate?.forecastViewControllerViewModel(self, forecastRequestError: error)
            
            } else if let forecasts = forecasts {

                self?.forecasts = forecasts
                self?.delegate?.forecastViewControllerViewModel(self, forecasts: forecasts)
            }
        }
    }
}

// MARK: UI

extension ForecastViewControllerViewModel {
    
    func dayLabelTitle() -> String? {
        
        return forecasts.first?.date?.dayOfWeek()
    }
    
    func degreesLabelTitle() -> String {
        
        if let dayTemperature = forecasts.first?.dayTemperature {
            
            return "\(dayTemperature)°C"
        }
        
        return ""
    }
}

// MARK: UITableView

extension ForecastViewControllerViewModel {
    
    func numberOfRows(in section: Int) -> Int {
        
        return forecasts.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.ForecastTableViewCell) as? ForecastTableViewCell {
            
            let dailyForecast = forecasts[indexPath.row + 1]
            cell.configure(with: dailyForecast)
            return cell
        }
        
        return UITableViewCell()
    }
}
