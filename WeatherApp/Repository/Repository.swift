//
//  Repository.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 24/10/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import Foundation

protocol RepositoryType: WeatherRepository {

}

class Repository: RepositoryType {

    let network: Network
    
    init(network: Network) {
        self.network = network
    }
}
