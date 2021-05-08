//
//  SharedData.swift
//  CryptoTracker
//
//  Created by Gawish on 07/05/2021.
//

import Foundation

struct SharedData {
    static var shared = SharedData(assets: [])
    var assets: [Asset]
    
    mutating func udpate(_ balance: [BinanceAccount.Balance]) {
        for b in balance {
            if let index = assets.firstIndex(where: { $0.name == b.asset }) {
                assets[index].amount = b.displayAmount
            } else {
                assets.append(Asset(name: b.asset, amount: b.displayAmount, price: 0))
            }
        }
    }
    
    mutating func udpate(_ balance: [CMCCoin]) {
        for b in balance {
            if let index = assets.firstIndex(where: { $0.name == b.symbol }) {
                assets[index].price = b.displayPrice
            } else {
                assets.append(Asset(name: b.symbol, amount: 0, price: b.displayPrice))
            }
        }
    }
}
