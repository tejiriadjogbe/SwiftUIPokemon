//
//  HttpClient.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//


import UIKit

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class HttpClient {

    static let shared = HttpClient()
    private let urlSession: URLSession
    
    private init() {
        // Configure URLCache with memory and disk capacity
        let memoryCapacity = 100 * 1024 * 1024
        let diskCapacity = 200 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "pokecache")

        // Configure URLSessionConfiguration with cache
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        configuration.requestCachePolicy = .returnCacheDataElseLoad

        self.urlSession = URLSession(configuration: configuration)
    }

    func fetchData<T: Codable>(
        url: String,
        data: Codable? = nil,
        method: HTTPMethod = .get,
        completion: @escaping (Result<T, ErrorResponse>) -> Void) {
            
        // Create a URLRequest with the desired URL
        guard let url = URL(string: url) else {
            // Handle invalid URL
            completion(.failure(ErrorResponse(message: "Invalid Url")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Encode the data and set the request body
        if method == .post, let data = data {
            do {
                let encoder = JSONEncoder()
                request.httpBody = try encoder.encode(data)
            } catch {
                completion(.failure(ErrorResponse(message: "Network error: \(error.localizedDescription)")))
                return
            }
        }
      
        //Use Cache if available
        if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: request) {
            print("Using cached response")
            if let result = try? JSONDecoder().decode(T.self, from: cachedResponse.data) {
                completion(.success(result))
                return
            }
        }
            
        // Perform the network request
        urlSession.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(ErrorResponse(message: error.localizedDescription)))
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(ErrorResponse(message: "Invalid Response")))
                    return
                }
                
                guard let data = data else {
                    // Handle nil Data
                    completion(.failure(ErrorResponse(message: "Invalid Response")))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    //Cache Data
                    let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
                    self.urlSession.configuration.urlCache?.storeCachedResponse(cachedResponse, for: request)
                    
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                default:
                    completion(.failure(ErrorResponse(httpStatusCode: httpResponse.statusCode, message: "Request failed with status code: \(httpResponse.statusCode)")))
                }
            } catch {
                completion(.failure(ErrorResponse(message: "Network error: \(error.localizedDescription)")))
            }
        }.resume()
    }
}


