//
//  newEnum.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 20.05.2025.
//

import Foundation

protocol Endpoint {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        request.httpBody = body
        return request
    }
}

final class NetworkClient {
    private let decoder = JSONDecoder()
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send<T: Endpoint>(_ endpoint: T) async throws -> T.Response {
        let (data, response) = try await session.data(for: endpoint.urlRequest)
        
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.http(http.statusCode)
        }

        return try decoder.decode(T.Response.self, from: data)
    }
}

struct LoginEndpoint: Endpoint {
    typealias Response = User

    let userID: Int

    var baseURL: URL {
        URL(string: "https://mai-students.ru/api/")!
    }

    var path: String {
        "v1/auth/register"
    }

    var method: String {
        "POST"
    }

    var headers: [String : String]? {
        ["Accept": "application/json",
         "Content-Type": "application/json"]
    }

    var body: Data? {
        nil
    }
}

#if DEBUG
extension Endpoint {
    var description: String {
        return urlRequest.description
    }
}
#endif
