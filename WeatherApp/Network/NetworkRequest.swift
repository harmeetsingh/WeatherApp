//
//  NetworkRequest.swift
//  NetAPorteriOSTest
//
//  Created by Harmeet Singh on 26/03/2019.
//  Copyright © 2019 Harmeet Singh. All rights reserved.
//

import Foundation

protocol NetworkRequest {

    // MARK: - Properties

    var endpoint: String { get }
    var query: String? { get }
    var method: HTTPMethodType { get }
    var headers: [String: String]? { get }
    var parameters: [String: AnyObject]? { get }

    func urlRequest(with domain: String) throws -> URLRequest
}

extension NetworkRequest {

    func urlRequest(with domain: String) throws -> URLRequest {

        var base = domain + endpoint

        if let query = query {
            base += query
        }

        guard let url = URL(string: base) else {
            throw NetworkRequestError.nilURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }

        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                             options: .prettyPrinted)
        }

        return urlRequest
    }
}
