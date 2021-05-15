//
//  Asset.swift
//  CryptoTracker
//
//  Created by Gawish on 07/05/2021.
//

import Foundation

struct Asset2 {
    var name: String
    var amount: Double
    var price: Double
    
    var value: Double {
        amount * price
    }
}
