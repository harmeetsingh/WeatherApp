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
    
    var viewModel: ForecastViewControllerViewModel!
    
    
    // MARK: Lifeycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureViewModel()
    }
    
    // MARK: Configuration
    
    func configureViewModel() {
        
        viewModel = ForecastViewControllerViewModel(delegate: self)
        viewModel.fetchForecast(for: 2648110)
    }
    
    func configureTodayForecast() {
        
        dayLabel.text = viewModel.dayLabelTitle()
        degreesLabel.text = viewModel.degreesLabelTitle()
    }
    
    func configurePatelView() {
        
        // Custom Direction
        
        pastelView?.startPastelPoint = .bottomLeft
        pastelView?.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView?.animationDuration = 3.0
        
        // Custom Color
        pastelView?.setPastelGradient(.winterNeva)
        
        pastelView?.startAnimation()
    }
    
    func configureRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        
    }

    func displayError(with error: Error) {
        
        cityLabel.text = ""
        degreesLabel.text = ""
        dayLabel.text = error.localizedDescription
    }
//}
//
//// MARK: ForecastViewControllerViewModelDelegate
//
//extension ForecastViewController: ForecastViewControllerViewModelDelegate {
 
    func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecasts: [Forecast]) {
        
         configureTodayForecast()
         configurePatelView()
         tableView.reloadData()
    }
    
    func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecastRequestError: Error) {
        
        displayError(with: forecastRequestError)
    }
}

// MARK: UITableViewDataSource

extension ForecastViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRows(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

