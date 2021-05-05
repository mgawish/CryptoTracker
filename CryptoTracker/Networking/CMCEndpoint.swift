//
//  CMCEndpoint.swift
//  CryptoTracker
//
//  Created by Gawish on 05/05/2021.
//

import Foundation

enum CMCEndpoint {
    case listing(sort: ListingResponse.SortOption)
}

extension CMCEndpoint: EndpointProtocol {
    var baseLink: String {
        Enviroment.shared.cmcBaseLink
    }
    
    var path: String {
        "/v1/cryptocurrency/listings/latest"
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .listing(let sort):
            return [
                URLQueryItem(name: "sort", value: sort.getStrings().0),
                URLQueryItem(name: "sort_dir", value: sort.getStrings().1)
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
