//
//  AssetsViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 13/04/2021.
//

import UIKit

class AssetsViewModel {
    var assets: [Asset] = [
        Asset(quantity: 1, coin: Coin.sampleData),
        Asset(quantity: 1, coin: Coin.sampleData)
    ]
    
    var assetsTotal: Double {
        assets.reduce(0) { $0 + $1.value }
    }
}
