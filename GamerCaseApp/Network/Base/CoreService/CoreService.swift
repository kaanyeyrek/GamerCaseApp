//
//  CoreService.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

protocol CoreServiceProtocol {
    func fetch<T: Decodable>(endPoint: HTTPEndPoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class CoreService: CoreServiceProtocol {
    func fetch<T>(endPoint: HTTPEndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path
        urlComponents.queryItems = endPoint.query
        
        guard let url = urlComponents.url else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.badData))
                print(error)
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))

                } catch {
                    print(error)
                    completion(.failure(.decoding))
                }
            default:
                print(response.statusCode)
                completion(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
}
