//  Copyright © 2021 Wilhelm Thieme

import Foundation

public protocol Api {
    func request<T: Endpoint>(_ endpoint: T) throws -> T.Response
}

final public class ApiImpl: NSObject, Api {
    lazy var scheme: String = "https"
    lazy var host: String = "api.airfranceklm.com"
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

    private let apiKey: String?
    private let verbose: Bool

    init(_ apiKey: String?, verbose: Bool = false) {
        self.apiKey = apiKey
        self.verbose = verbose
    }

    public func request<T: Endpoint>(_ endpoint: T) throws -> T.Response {
        let urlString = "\(scheme)://\(host)\(endpoint.endpoint)"
        guard let url = URL(string: urlString) else { throw ApiError.malformedUrl(urlString: urlString) }
        guard let apiKey = apiKey else { throw ApiError.noApiKey() }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "accept": "application/hal+json",
            "accept-language": "en-US",
            "content-type": "application/json",
            "afkl-travel-country": "NL",
            "afkl-travel-host": "KL",
            "api-key": apiKey
        ]
        request.httpBody = try encoder.encode(endpoint.payload)
        request.httpMethod = "POST"

        let response = try syncRequest(request)
        return try decoder.decode(T.Response.self, from: response)
    }

    private func syncRequest(_ request: URLRequest) throws -> Data {
        printRequest(request)

        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { aData, aResponse, aError in
            data = aData
            response = aResponse
            error = aError
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)

        if let error = error { throw error }
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiError.emptyResponse() }
        printResponse(httpResponse, data)
        guard (200..<300).contains(httpResponse.statusCode) else { throw ApiError.httpError(statusCode: httpResponse.statusCode) }
        guard let data = data else { throw ApiError.emptyBody() }
        return data
    }

    private func printRequest(_ request: URLRequest) {
        guard verbose else { return }
        print("Request: \(request.url?.absoluteString ?? "Unknown")")
        print()
        print("Headers:")
        request.allHTTPHeaderFields?.forEach { print("\($0.key): \($0.value)") }
        print()
        print("Payload:")
        print(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "null")
        print()
        print()
    }

    private func printResponse(_ response: HTTPURLResponse, _ data: Data?) {
        guard verbose else { return }
        print("Response: \(response.statusCode)")
        print()
        print("Headers:")
        response.allHeaderFields.forEach { print("\($0.key): \($0.value)") }
        print()
        print("Payload:")
        print(String(data: data ?? Data(), encoding: .utf8) ?? "null")
        print()
        print()
    }
}

enum ApiError: EnumError {
    case malformedUrl(urlString: String)
    case emptyResponse(Void = ())
    case emptyBody(Void = ())
    case httpError(statusCode: Int)
    case noApiKey(Void = ())
}

public protocol Endpoint {
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    var endpoint: String { get }
    var payload: Request { get }
}
