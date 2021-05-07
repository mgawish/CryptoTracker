//
//  BinanceEndpoint.swift
//  CryptoTracker
//
//  Created by Gawish on 05/05/2021.
//

import Foundation

enum BinanceEndpoint {
    case systemStatus
    case serverTime
    case account(timestamp: String)
    case snapshot(timestamp: String)
    
    func generateSignture(_ queryItems: [URLQueryItem]) -> String {
        let urlString = self.baseLink + self.path
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url?.query?.digest(.sha256, key: Enviroment.shared.binanceApiSecret) ?? ""
    }
}

extension BinanceEndpoint: EndpointProtocol {
    var baseLink: String {
        Enviroment.shared.binanceBaseLink
    }
    
    var path: String {
        switch self {
        case .systemStatus:
            return "/wapi/v3/systemStatus.html"
        case .serverTime:
            return "/api/v3/time"
        case .snapshot:
            return "/sapi/v1/accountSnapshot"
        case .account:
            return "/api/v3/account"
        }
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .systemStatus:
            return []
        case .snapshot(let timestamp):
            var queryItems = [
                URLQueryItem(name: "timestamp", value: "\(timestamp)"),
                URLQueryItem(name: "type", value: "SPOT"),
                URLQueryItem(name: "limit", value: "30")
            ]
            queryItems.append(URLQueryItem(name: "signature", value: generateSignture(queryItems)))
           return queryItems
        case .account(let timestamp):
            var queryItems = [
                URLQueryItem(name: "timestamp", value: "\(timestamp)")
            ]
            queryItems.append(URLQueryItem(name: "signature", value: generateSignture(queryItems)))
            return queryItems
        default:
            return []
        }
        
    }
    
    var headers: [String : String] {
        [
            "Accept": "*/*",
            "Accept-Encoding": "gzip, deflate, br",
            "Content-Type": "application/json",
            "Connection": "keep-alive",
            "X-MBX-APIKEY": Enviroment.shared.binanceApiKey
        ]
    }
}
