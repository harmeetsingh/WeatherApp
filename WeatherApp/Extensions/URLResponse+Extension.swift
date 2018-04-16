//
//  URLResponse+Extension.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 15/04/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

extension URLResponse {
    
    func isRequestSuccessful() -> Bool {
        
        let httpResponse = self as? HTTPURLResponse
        return httpResponse?.statusCode == 200
    }
}
