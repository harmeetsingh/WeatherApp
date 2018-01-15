//
//  XCTest+Extension.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import XCTest

extension XCTest {
    
    func urlResponse(with statusCode: Int) -> URLResponse? {
        
        if let url = URL(string: "http://api.openweathermap.org") {
            
            return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "1.1", headerFields: nil)
        }
        
        return nil
    }
    
    func data(for fileName: String, className: AnyClass) -> Data? {
        
        if let url = Bundle(for: className.self).url(forResource: fileName, withExtension: "json") {
            
            return try? Data(contentsOf: url)
        }
        
        return nil
    }
    
}
