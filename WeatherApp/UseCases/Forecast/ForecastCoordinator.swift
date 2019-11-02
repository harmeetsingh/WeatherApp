//
//  ForecastCoordinator.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 24/10/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import UIKit

protocol ForecastCoordinatorType: Coordinator {

    func start(on window: UIWindow)
}

class ForecastCoordinator: ForecastCoordinatorType {
    
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func start(on window: UIWindow) {
        
        let viewController: ForecastViewController = .fromStoryboard()
        viewController.viewModel = ForecastViewControllerViewModel(repository: repository)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }    
}

