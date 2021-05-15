//
//  SharedData.swift
//  CryptoTracker
//
//  Created by Gawish on 07/05/2021.
//

import CoreData
import UIKit

struct SyncCoordinator {
    static var shared = SyncCoordinator()
    var coins = [CMCCoin]()
    
    func getAssets() -> [Asset] {
        let request = Asset.createFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let assets = try? persistentContainer.viewContext.fetch(request)
        return assets ?? []
    }
    
    mutating func udpate(_ allBalance: [BinanceAccount.Balance]) {
        let balance = allBalance.filter({ $0.displayAmount != 0 })
        let context = persistentContainer.viewContext
        
        for b in balance {
            let request = Asset.createFetchRequest()
            let coin = coins.first(where: {$0.symbol == b.asset })
            request.predicate = NSPredicate(format: "name == %@ AND source == %@", b.asset, Source.binance.rawValue)
            if let asset = try? context.fetch(request).first {
                asset.amount = b.displayAmount
                asset.price = coin?.displayPrice ?? 0
            } else {
                let asset = Asset(context: context)
                asset.name = b.asset
                asset.amount = b.displayAmount
                asset.price = coin?.displayPrice ?? 0
                asset.source = Source.binance.rawValue
            }
            saveContext()

        }
    }
    
    // MARK: - Core Data stack

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    mutating func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension SyncCoordinator {
    enum Source: String {
        case binance
    }
}
