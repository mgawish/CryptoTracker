//
//  ListingResponse.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

struct ListingResponse: Codable {
    let data: [Coin]?
    let status: ResponseStatus
}

extension ListingResponse {
    enum SortOption {
        case nameAsc
        case nameDesc
        case marketCapAsc
        case martketCapDesc
        
        func getStrings() -> (String, String) {
            switch self {
            case .nameAsc: return ("name", "asc")
            case .nameDesc: return ("name", "desc")
            case .marketCapAsc: return ("market_cap", "asc")
            case .martketCapDesc: return ("market_cap", "desc")
            }
        }
    }
}
