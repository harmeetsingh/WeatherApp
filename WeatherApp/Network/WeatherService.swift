//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    
    // MARK: Properties
    
    fileprivate let urlSession: URLSession
    let appID: String
    
    // MARK: Instantiation
    
    init(urlSession: URLSession, appID: String = "a78f88499f4ad371151071ae9cf48f00") {
        
        self.urlSession = urlSession
        self.appID = appID
    }
    
    // MARK: WeatherServiceProtocol
    
    func fetchForecast(for cityID: Int, completion: @escaping ForecastCompletion) {
        
        guard cityID > 0 && String(cityID).count == 7 else {
            
            return completion(nil, WeatherServiceError.cityIDInvalidValue)
        }
        
        guard let request = ForecastRequest(cityID:cityID, appID: appID).request else {
            
            return completion(nil, WeatherServiceError.forecastRequestNil)  // TODO: test this case
        }
        
        sendForecastRequest(with: request, completion: completion)
    }
}

// MARK: Fetching forecast

private extension WeatherService {
    
    func sendForecastRequest(with request: URLRequest, completion: @escaping ForecastCompletion) {
        
        urlSession.dataTask(with: request) { (responseData: Data?, response: URLResponse?, error: Error?)  in
            
            if let error = error {
                
                return self.forecastRequestCompleted(with: nil, error: error, completion: completion)
            }
            
            if response?.isRequestSuccessful() == true {
                
                do {
                    
                    let allForecasts = try self.allForecasts(from: responseData)
                    return self.forecastRequestCompleted(with: allForecasts, error: nil, completion: completion)
                    
                } catch let serializationError {
                    
                    return self.forecastRequestCompleted(with: nil, error: serializationError, completion: completion)
                }
            }
            
            return self.forecastRequestCompleted(with: nil, error: WeatherServiceError.requestFailed, completion: completion)
            
        }.resume()
    }
    
    func forecastRequestCompleted(with forecasts: [Forecast]?, error: Error?, completion: @escaping (_ forecasts: [Forecast]?, _ error: Error?) -> Void) {
        
        DispatchQueue.main.async {
            
            completion(forecasts, error)
        }
    }
    
    func allForecasts(from data: Data?) throws -> [Forecast]? {
        
        var allForecasts = [Forecast]()
        
        guard let data = data else {
            
            throw WeatherServiceError.responseDataNil
        }
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
            
            if let list = json?[Constants.ParsingKeys.ListKey] {
             
                let listData = try JSONSerialization.data(withJSONObject: list, options: .prettyPrinted)
                allForecasts = try JSONDecoder().decode([Forecast].self, from: listData)
            }
            
        } catch let error  {
            
            throw error
        }
        
        return allForecasts
    }
}
