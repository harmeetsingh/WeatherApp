import Foundation

protocol NetworkImageRequest {

    // MARK: - Properties

    var url: URL { get }

    func urlRequest() -> URLRequest
}

extension NetworkImageRequest {

    func urlRequest() -> URLRequest {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethodType.get.rawValue
        return urlRequest
    }
}

