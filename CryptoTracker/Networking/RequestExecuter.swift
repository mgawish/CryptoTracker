//
//  RequestExecuter.swift
//  CryptoTracker
//
//  Created by Gawish on 11/04/2021.
//

import Foundation

struct RequestExecuter<T:Decodable> {
    var request: URLRequest
    
    init(_ endpoint: EndpointProtocol) throws {
        let urlString = endpoint.baseLink + endpoint.path
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = endpoint.params
        guard let url = urlComponents?.url else {
            throw NetworkError.invalidUrl
        }
        
        print(url.absoluteString)
        request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        request.allHTTPHeaderFields = endpoint.headers
    }
    
    func execute(completion: @escaping (T?, Error?)->()) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError.invalidResponse)
                return
            }
            
            if httpResponse.statusCode != 200 {
                completion(nil, NetworkError.responseError)
            }
            
            if let _ = error {
                completion(nil, NetworkError.responseError)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.dataError)
                return
            }
            
            let decoder = JSONDecoder()
            guard let model = try? decoder.decode(T.self, from: data) else {
                print("🚨 \(String(describing: String(data: data, encoding: .utf8)))")
                completion(nil, NetworkError.responseError)
                return
            }
            
            completion(model, nil)
        }
        
        task.resume()
    }
}


