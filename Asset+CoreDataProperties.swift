//
//  Asset+CoreDataProperties.swift
//  CryptoTracker
//
//  Created by Gawish on 15/05/2021.
//
//

import Foundation
import CoreData


extension Asset {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Asset> {
        return NSFetchRequest<Asset>(entityName: "Asset")
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String
    @NSManaged public var source: String
    @NSManaged public var portfolios: NSSet?
    @NSManaged public var coin: Coin
    
    func configure(_ balance: BinanceAccount.Balance) {
        self.name = balance.asset
        self.amount = balance.displayAmount
        self.source = Source.binance.rawValue

    }
    
    func configure(_ coin: Coin, amount: Double) {
        self.name = coin.symbol
        self.amount = amount
        self.source = Source.offline.rawValue
    }
    
    func update(_ balance: BinanceAccount.Balance) {
        self.amount = balance.displayAmount
    }
}

extension Asset : Identifiable {

}
