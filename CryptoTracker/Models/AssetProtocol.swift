//
//  AssetProtocol.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//

import Foundation

protocol AssetProtocol {
    var amount: Double { get }
    var name: String { get }
    var price: Double { get }
}
