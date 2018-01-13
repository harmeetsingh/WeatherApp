//
//  ForecastRequest.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

struct ForecastRequest: WeatherRequestProtocol {
    
    // MARK: Properties
    
    private let cityID: Int
    private let appID: String
    
    // MARK: Instantiation
    
    init(cityID: Int, appID: String) {
        
        self.cityID = cityID
        self.appID = appID
    }
    
    // MARK: WeatherRequestProtocol
    
    var domain: String = "http://api.openweathermap.org"
    
    var endpoint: String = "/data/2.5/forecast/daily"
    
    var method: Constants.HTTPMethods = .get
    
    var query: String? {
        
        var baseQuery = "?"
        
        baseQuery += "id=\(cityID)"
        baseQuery += "&appid=\(appID)"
        baseQuery += "&units=metric"
        
        return baseQuery
    }
    
    var headers: [String: String]? = nil
    
    var parameters: [String: AnyObject]? = nil
    
    var request: URLRequest? {
        
        guard let query = query  else {
            
            return nil
        }
        
        let fullURLString = domain + endpoint + query
        let url = URL(string: fullURLString)
        
        if let url = url {
            
            var urlRequest = NSURLRequest(url: url) as URLRequest
            urlRequest.httpMethod = method.rawValue
            
            return urlRequest
        }
  
        return nil
    }
}
