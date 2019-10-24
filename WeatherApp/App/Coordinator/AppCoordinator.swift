//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 24/10/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import UIKit

protocol AppCoordinatorType: Coordinator {

    func start(on window: UIWindow)
}

class AppCoordinator: AppCoordinatorType {

    func start(on window: UIWindow) {
        
        let viewController: ForecastViewController = .fromStoryboard()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }    
}
