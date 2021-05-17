//
//  Coin+CoreDataProperties.swift
//  CryptoTracker
//
//  Created by Gawish on 17/05/2021.
//
//

import Foundation
import CoreData


extension Coin {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Coin> {
        return NSFetchRequest<Coin>(entityName: "Coin")
    }

    @NSManaged public var name: String
    @NSManaged public var symbol: String
    @NSManaged public var price: Double
    @NSManaged public var cmcRank: Int
    @NSManaged public var slug: String
    @NSManaged public var assets: NSSet
    
    func configure(_ cmcCoin: CMCCoin) {
        self.name = cmcCoin.name
        self.price = cmcCoin.price
        self.symbol = cmcCoin.symbol
        self.slug = cmcCoin.slug
        self.cmcRank = cmcCoin.cmc_rank
    }

    func update(_ cmcCoin: CMCCoin) {
        self.symbol = cmcCoin.symbol
        self.price = cmcCoin.price
        self.cmcRank = cmcCoin.cmc_rank
    }
}

extension Coin : Identifiable {

}
