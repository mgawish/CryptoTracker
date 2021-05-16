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
    
    init(_ asset: Asset, sources: [String]) {
        self.name = asset.name
        self.price = asset.price
        self.amount = asset.amount
        self.sources = sources
    }
}
