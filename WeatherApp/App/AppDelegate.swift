//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            return false
        }

        let networkSession = NetworkSession(session: URLSession.shared,
                                            domain: "https://api.openweathermap.org",
                                            appID: "a78f88499f4ad371151071ae9cf48f00")
        let repository = Repository(network: networkSession)
        let coordinatorFactory = CoordinatorFactory(repository: repository)
        let forecastCoordinator = coordinatorFactory.makeForecast()
        forecastCoordinator.start(on: window)
        return true
    }
}

