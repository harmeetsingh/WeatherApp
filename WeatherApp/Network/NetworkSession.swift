import Foundation

class NetworkSession: Network {
    

    // MARK: - Properties

    let session: URLSession
    let domain: String
    let appID: String

    // MARK: - Init

    init(session: URLSession, domain: String, appID: String) {

        self.session = session
        self.domain = domain
        self.appID = appID
    }

    // MARK: - Load

    func load(request: NetworkRequest, decoder: NetworkResponseDecoder, completion: @escaping (Result<Decodable, Error>) -> Void) {

        do {

            let urlRequest = try request.urlRequest(with: domain, appID: appID)

            perform(request: urlRequest) { result in

                switch result {

                case .failure(let error):
                    completion(.failure(error))

                case .success(let data):
                    
                    do {
                        let decodable = try decoder.decode(data: data)
                        completion(.success(decodable))

                    } catch let decodingError {
                        completion(.failure(decodingError))
                    }
                }
            }

        } catch let requestError {

            completion(.failure(requestError))
        }
    }

    func loadImage(request: NetworkImageRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        let urlRequest = request.urlRequest()

        perform(request: urlRequest) { result in

            switch result {

            case .failure(let error):
                completion(.failure(error))

            case .success(let data):
                completion(.success(data))
            }
        }
    }

    private func perform(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        session.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard response?.isSuccessfull == true else {
                    completion(.failure(NetworkSessionError.unsuccessfulRequest(response)))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkSessionError.nilResponseData))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }
}
