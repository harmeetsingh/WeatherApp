//
//  ViewController.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit
import Pastel
import Bond
import ReactiveKit

class ForecastViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pastelView: PastelView!
    
    var viewModel: ForecastViewControllerViewModelType!
    private let refreshControl = UIRefreshControl()
    
    // MARK: Lifeycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configurePatelView()
        configureRefreshControl()
        bind(viewModel.outputs)
        viewModel.inputs.load()
    }
    
    // MARK: Configuration

    private func configurePatelView() {
        
        // Custom Direction
        pastelView?.startPastelPoint = .bottomLeft
        pastelView?.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView?.animationDuration = 3.0
        
        // Custom Color
        let gradient = PastelGradient.randomGradient()
        pastelView?.setPastelGradient(gradient)
        
        pastelView?.startAnimation()
    }
    
    private func configureRefreshControl() {
        
        tableView.addSubview(refreshControl)
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
    }
    
    @objc private func refreshTriggered() {
        viewModel.inputs.load()
    }
    
    private func bind(_ outputs: ForecastViewControllerViewModelOutput) {
        
        outputs.city
            .bind(to: cityLabel.reactive.text)
        
        outputs.temperature
            .bind(to: degreesLabel.reactive.text)
        
        outputs.day
            .bind(to: dayLabel.reactive.text)
        
        outputs.isLoading
            .bind(to: refreshControl.reactive.refreshing)
        
        outputs.cellViewModels
            .bind(to: tableView) { dataSource, indexPath, tableView in            
                let cell = tableView.dequeueCell(of: ForecastTableViewCell.self, for: indexPath)
                cell.viewModel = dataSource[indexPath.row]
                return cell
        }
    }
}
