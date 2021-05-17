//
//  Portfolio+CoreDataProperties.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//
//

import Foundation
import CoreData


extension Portfolio {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Portfolio> {
        return NSFetchRequest<Portfolio>(entityName: "Portfolio")
    }

    @NSManaged public var name: String?
    @NSManaged public var assets: NSSet?

}

// MARK: Generated accessors for assets
extension Portfolio {

    @objc(addAssetsObject:)
    @NSManaged public func addToAssets(_ value: Asset)

    @objc(removeAssetsObject:)
    @NSManaged public func removeFromAssets(_ value: Asset)

    @objc(addAssets:)
    @NSManaged public func addToAssets(_ values: NSSet)

    @objc(removeAssets:)
    @NSManaged public func removeFromAssets(_ values: NSSet)

}

extension Portfolio : Identifiable {

}
