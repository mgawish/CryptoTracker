//
//  RequestExecuter.swift
//  CryptoTracker
//
//  Created by Gawish on 11/04/2021.
//

import Foundation

struct RequestGenerator {
    var request: URLRequest
    
    init(urlString: String, queryParams: [URLQueryItem]) throws {
        
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NetworkError.invalidUrl
        }
        
        urlComponents.queryItems = queryParams
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidUrl
        }
        
        request = URLRequest(url: url)

        request.allHTTPHeaderFields = [
            "X-CMC_PRO_API_KEY": Enviroment.shared.cmcApiKey,
            "Accept-Encoding": "gzip, deflate, br",
            "Accept": "application/json"
        ]
    }
}


