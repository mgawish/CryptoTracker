//
//  AssetCellViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//

import Foundation

struct AssetCellViewModel {
    let name: String
    var price: Double
    var amount: Double
    var sources: [String]
    var percentage: Double?
    
    init(_ asset: Asset, sources: [String]) {
        self.name = asset.name
        self.price = asset.coin.price
        self.amount = asset.amount
        self.sources = sources
    }
}
