//
//  CMCEndpoint.swift
//  CryptoTracker
//
//  Created by Gawish on 05/05/2021.
//

import Foundation

enum CMCEndpoint {
    case listing(sort: ListingResponse.SortOption)
    case quote(symbol: String)
}

extension CMCEndpoint: EndpointProtocol {
    var baseLink: String {
        Enviroment.shared.cmcBaseLink
    }
    
    var path: String {
        switch self {
        case .listing(_):
            return "/v1/cryptocurrency/listings/latest"
        case .quote(_):
            return "/v1/cryptocurrency/quotes/latest"
        }
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .listing(let sort):
            return [
                URLQueryItem(name: "sort", value: sort.getStrings().0),
                URLQueryItem(name: "sort_dir", value: sort.getStrings().1)
            ]
        case.quote(let symbol):
            return [
                URLQueryItem(name: "symbol", value: symbol)
            ]
        }
    }
    
    var headers: [String : String] {
        [
            "X-CMC_PRO_API_KEY": Enviroment.shared.cmcApiKey,
            "Accept-Encoding": "gzip, deflate, br",
            "Accept": "application/json"
        ]
    }
}
