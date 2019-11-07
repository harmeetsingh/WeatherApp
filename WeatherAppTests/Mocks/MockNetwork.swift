//
//  NetworkMock.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 07/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import Foundation
@testable import WeatherApp

class MockNetwork: Network {

    var responseObject: Decodable? = nil
    var returnsResponseError = true
    func load(request: NetworkRequest, decoder: NetworkResponseDecoder, completion: @escaping (Result<Decodable, Error>) -> Void) {

        guard returnsResponseError == false else {

            completion(.failure(MockError.instance))
            return
        }
        
        guard let responseObject = responseObject else { 
            return 
        }
        
        completion(.success(responseObject))
    }
    
    func loadImage(request: NetworkImageRequest, completion: @escaping (Result<Data, Error>) -> Void) {

    }    
}
