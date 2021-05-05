//
//  BinanceEndpoint.swift
//  CryptoTracker
//
//  Created by Gawish on 05/05/2021.
//

import Foundation

enum BinanceEndpoint {
    case systemStatus
    case snapshot(timestamp: String, signature: String)
}

extension BinanceEndpoint: EndpointProtocol {
    var baseLink: String {
        Enviroment.shared.binanceBaseLink
    }
    
    var path: String {
        switch self {
        case .systemStatus:
            return "/wapi/v3/systemStatus.html"
        case .snapshot:
            return "/wapi/v3/accountStatus.html"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .systemStatus:
            return []
        case .snapshot(let timestamp, let signature):
            return [
                URLQueryItem(name: "timestamp", value: timestamp),
                URLQueryItem(name: "signature", value: signature)
            ]
        }
    }
    
    var headers: [String : String] {
        [
            "Accept-Encoding": "gzip, deflate, br",
            "Content-Type": "application/json",
            "Connection": "keep-alive",
            "X-MBX-APIKEY": Enviroment.shared.binanceApiKey
        ]
    }
    
    
}
