//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherService: WeatherServiceProtocol {
    
    // MARK: Properties
    
    fileprivate let urlSession: URLSession
    private let appID: String = "a78f88499f4ad371151071ae9cf48f00"
    
    // MARK: Instantiation
    
    init(urlSession: URLSession) {
        
        self.urlSession = urlSession
    }
    
    // MARK: WeatherServiceProtocol
    
    func fetchForecast(for cityID: Int, completion: @escaping ForecastCompletion) {
        
        guard let request = ForecastRequest(cityID:cityID, appID: appID).request else {
            
            return completion(nil, WeatherServiceError.nilForecastRequest)  // TODO: test this case
        }
        
        sendForecastRequest(with: request, completion: completion)
    }
}

// MARK: Fetching forecast

extension WeatherService {
    
    func sendForecastRequest(with request: URLRequest, completion: @escaping ForecastCompletion) {
        
        urlSession.dataTask(with: request) { (responseData: Data?, response: URLResponse?, error: Error?)  in
            
            if let error = error {
                
                return self.forecastRequestCompleted(with: nil, error: error, completion: completion)
            }
            
            if self.isRequestSuccessful(for: response) {
                
                do {
                    
                    let allForecasts = try self.allForecasts(from: responseData)
                    return self.forecastRequestCompleted(with: allForecasts, error: nil, completion: completion)
                    
                } catch let error {
                    
                    return self.forecastRequestCompleted(with: nil, error: error, completion: completion)
                }
            }
            
            return self.forecastRequestCompleted(with: nil, error: WeatherServiceError.requestFailed, completion: completion)
            
        }.resume()
    }
    
    func isRequestSuccessful(for response: URLResponse?) -> Bool {
        
        let httpResponse = response as? HTTPURLResponse
        return httpResponse?.statusCode == 200
    }
    
    func forecastRequestCompleted(with forecasts: [Forecast]?, error: Error?, completion: @escaping (_ forecasts: [Forecast]?, _ error: Error?) -> Void) {
        
        DispatchQueue.main.async {
            
            completion(forecasts, error)
        }
    }
    
    func allForecasts(from data: Data?) throws -> [Forecast]? {
        
        var allForecasts = [Forecast]()
        
        guard let data = data else {
            
            throw WeatherServiceError.nilResponseData
        }
        
        let json = try? JSON(data: data)
        
        if let list = json?[Constants.ParsingKeys.ListKey].array {
            
            for item in list {
                
                let forecast = Forecast(with: item)
                allForecasts.append(forecast)
            }
        }
        
        return allForecasts
    }
}
