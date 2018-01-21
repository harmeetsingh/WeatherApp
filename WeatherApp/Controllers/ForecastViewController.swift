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
    
    private var viewModel: ForecastViewControllerViewModel!
    private let refreshControl = UIRefreshControl()
    
    
    // MARK: Lifeycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureViewModel()
        configureRefreshControl()
    }
    
    // MARK: Configuration
    
    func configureViewModel() {
        
        viewModel = ForecastViewControllerViewModel(delegate: self)
        fetchForecasts()
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
        let gradient = viewModel.pastelViewGradient()
        pastelView?.setPastelGradient(gradient)
        
        pastelView?.startAnimation()
    }
    
    func configureRefreshControl() {
        
        tableView.addSubview(refreshControl)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(fetchForecasts), for: .valueChanged)
    }
    
    // MARK: Forecast fetch
    
    @objc func fetchForecasts() {
        
        refreshControl.beginRefreshing()
        viewModel.fetchForecast(for: 2648110)
    }
    
    // MARK: ForecastViewControllerViewModelDelegate
 
    func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecasts: [Forecast]) {
        
        configureTodayForecast()
        configurePatelView()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func forecastViewControllerViewModel(_ viewModel: ForecastViewControllerViewModel?, forecastRequestError: Error) {
        
        cityLabel.text = ""
        degreesLabel.text = ""
        dayLabel.text = forecastRequestError.localizedDescription
        refreshControl.endRefreshing()
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

