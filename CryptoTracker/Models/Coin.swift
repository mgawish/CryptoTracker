//
//  Currency.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation


struct Coin: Codable {
    let id: Int
    let name: String
    let symbol: String
    let quote: Quote
    let slug: String
    
    var displayPrice: Double {
        Double(round(quote.USD.price * 100) / 100)
    }
    
    var displayChange: Double {
        Double(round(quote.USD.percent_change_24h * 100) / 100)
    }
}

extension Coin {
    struct Quote: Codable {
        let USD: PriceBreakdown
    }
}

extension Coin {
    struct PriceBreakdown: Codable {
        let price: Double
        let percent_change_24h: Double
    }
}

extension Coin {
    static let sampleData = Coin(id: 1,
                                 name: "Bitcoin",
                                 symbol: "BTC",
                                 quote: Quote(USD: PriceBreakdown(price: 63328.262294438355,
                                                                  percent_change_24h: 5.70085299)),
                                 slug: "bitcoin")
}
