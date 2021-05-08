//
//  AccountResponse.swift
//  CryptoTracker
//
//  Created by Gawish on 07/05/2021.
//

import Foundation

struct BinanceAccount: Codable {
    let updateTime: Double
    let balances: [Balance]
}

extension BinanceAccount {
    struct Balance: Codable {
        let asset: String
        let free: String
        let locked: String
        
        var displayAmount: Double {
            Double(free) ?? 0
        }
    }
}
