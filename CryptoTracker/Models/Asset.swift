//
//  Asset.swift
//  CryptoTracker
//
//  Created by Gawish on 13/04/2021.
//

import Foundation

struct Asset {
    var quantity: Double
    var coin: Coin
    
    var value: Double {
        Double(round(quantity * coin.quote.USD.price * 100) / 100)
    }
}
