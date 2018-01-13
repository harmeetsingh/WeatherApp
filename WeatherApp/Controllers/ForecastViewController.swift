//
//  ViewController.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit
import Pastel

class ForecastViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pastelView: PastelView!
    
    let weatherService = WeatherService(urlSession: URLSession.shared)
    var forecasts: [Forecast] = []
    
    // MARK: Lifeycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        fetchForecast(for: 2648110)
    }
    
    // MARK: Fetch forecasts
    
    func fetchForecast(for cityID: Int) {
        
        weatherService.fetchForecast(for:cityID) { [weak self] (forecasts: [Forecast]?, error: Error?) in
            
            if let error = error {
                
                self?.displayError(with: error)
            }
            
            if let forecasts = forecasts {
            
                self?.forecasts = forecasts
                self?.configureTodayForecast()
                self?.configurePatelView()
                self?.tableView.reloadData()
            }
        }
    }
    
    func configureTodayForecast() {
        
        let todayForecast = self.forecasts.first
        
        if let date = todayForecast?.date {
            
            dayLabel.text = date.dayOfWeek()
        }
        
        if let degrees = todayForecast?.dayTemperature {
            
            degreesLabel.text = "\(degrees)°C"
        }
    }
    
    func configurePatelView() {
        
        // Custom Direction
        
        pastelView?.startPastelPoint = .bottomLeft
        pastelView?.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView?.animationDuration = 3.0
        
        // Custom Color
//        pastelView?.setPastelGradient(.frozenDreams)
        
        pastelView?.startAnimation()
    }

    func displayError(with error: Error) {
        
        cityLabel.text = ""
        degreesLabel.text = ""
        dayLabel.text = error.localizedDescription
    }
}

// MARK: UITableViewDataSource

extension ForecastViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecasts.count - 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastTableViewCell") as? ForecastTableViewCell {
            
            let dailyForecast = forecasts[indexPath.row + 1]
            cell.configure(with: dailyForecast)
            return cell
        }
        
        return UITableViewCell()
    }
    
}

