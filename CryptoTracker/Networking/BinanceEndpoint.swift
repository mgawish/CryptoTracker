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
    case snapshot(timestamp: String, signature: String?)
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
        }
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .systemStatus:
            return []
        case .snapshot(let timestamp, let signature):
            var query = [
                URLQueryItem(name: "timestamp", value: timestamp),
                URLQueryItem(name: "type", value: "SPOT")
            ]
            if let signature = signature {
                query.append(URLQueryItem(name: "signature", value: signature))
            }
           return query
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
