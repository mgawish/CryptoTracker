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
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var source: String?

}

extension Asset : Identifiable {

}
