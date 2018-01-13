//
//  WeatherRequestProtocol.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

protocol WeatherRequestProtocol {
    
    // MARK: Properties
    
    var domain: String { get }
    var endpoint: String { get }
    var method: Constants.HTTPMethods { get }
    var query: String? { get }
    var headers: [String: String]? { get }
    var parameters: [String: AnyObject]? { get }
    var request: URLRequest? { get }
}
