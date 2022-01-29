//  Copyright © 2021 Wilhelm Thieme

import Foundation
import Combine

let api = Api()

final public class Api {
    fileprivate init() { }
    lazy var session: URLSession = URLSession.shared

    lazy var encoder: JSONEncoder = {
        let enc = JSONEncoder()
        enc.dataEncodingStrategy = .base64
        enc.dateEncodingStrategy = .iso8601
        return enc
    }()

    lazy var decoder: JSONDecoder = {
        let dec = JSONDecoder()
        dec.dataDecodingStrategy = .base64
        dec.dateDecodingStrategy = .iso8601
        return dec
    }()

    public func request<T: Endpoint>(_ endpoint: T) -> AnyPublisher<T.Response, Error> {
        return Just(endpoint.payload)
            .encode(encoder: encoder)
            .zip(Just(endpoint.endpoint).setFailureType(to: Error.self))
            .tryMap(createRequest)
            .flatMap(callRequest)
            .tryMap(validateResponse)
            .decode(type: T.Response.self, decoder: decoder)
            .receive(on: DispatchQueue.main, options: nil)
            .eraseToAnyPublisher()
    }

    private func createRequest(payload: Data, urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else { throw ApiError.malformedUrl(urlString: urlString) }
        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = [
            "accept": "application/hal+json",
            "accept-language": "en-US",
            "afkl-travel-country": "NL",
            "afkl-travel-host": "KL",
            "api-key": "<api-key>"
        ]

        return request
    }

    private func validateResponse(_ data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiError.emptyResponse() }
        guard (200..<300).contains(httpResponse.statusCode) else { throw ApiError.httpError(statusCode: httpResponse.statusCode) }
        return data
    }

    private func callRequest(_ request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        return session.dataTaskPublisher(for: request)
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }

}

enum ApiError: EnumError {
    case malformedUrl(urlString: String)
    case emptyResponse(Void = ())
    case httpError(statusCode: Int)
}

public protocol Endpoint {
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    var endpoint: String { get }
    var payload: Request { get }
}

