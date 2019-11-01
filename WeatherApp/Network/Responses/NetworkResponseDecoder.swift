import Foundation

protocol NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable
}
