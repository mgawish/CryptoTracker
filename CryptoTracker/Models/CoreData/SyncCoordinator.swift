//
//  SharedData.swift
//  CryptoTracker
//
//  Created by Gawish on 07/05/2021.
//

import CoreData
import UIKit

class SyncCoordinator {
    static var shared = SyncCoordinator()
    
    func getAssets(name: String? = nil) -> [Asset] {
        let request = Asset.createFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        if let name = name {
            request.predicate = NSPredicate(format: "name == %@", name)
        }
        let assets = try? persistentContainer.viewContext.fetch(request)
        return assets ?? []
    }
    
    func getCoins(symbol: String? = nil) -> [Coin] {
        let request = Coin.createFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "cmcRank", ascending: true)]
        if let symbol = symbol {
            request.predicate = NSPredicate(format: "symbol == %@", symbol)
        }
        let coins = try? persistentContainer.viewContext.fetch(request)
        return coins ?? []
    }
    
    //MARK:- Update binance
    func udpate(_ allBalance: [BinanceAccount.Balance]) {
        let balance = allBalance.filter({ $0.displayAmount != 0 })
        
        for b in balance {
            let request = Asset.createFetchRequest()
            request.predicate = NSPredicate(format: "name == %@ AND source == %@",
                                            b.asset,
                                            Asset.Source.binance.rawValue)
            if let asset = try? persistentContainer.viewContext.fetch(request).first {
                asset.amount = b.displayAmount
                print("\(asset.name) updated from binance")
            } else {
                let asset = Asset(context: persistentContainer.viewContext)
                asset.configure(b)
                attachCoin(to: asset)
                print("\(asset.name) created from binance")
            }
        }
        DispatchQueue.main.async {
            self.saveContext()
        }
    }
    
    func attachCoin(to asset: Asset) {
        let request = Coin.createFetchRequest()
        request.predicate = NSPredicate(format: "symbol == %@", asset.name)
        if let coin = try?  persistentContainer.viewContext.fetch(request).first {
            asset.coin = coin
            print("\(coin.name) coin attached to asset")
        }
    }
    
    //MARK:- Update offline
    func update(_ coin: Coin, amount: Double) {
        let request = Asset.createFetchRequest()
        request.predicate = NSPredicate(format: "name == %@ AND source == %@",
                                        coin.symbol,
                                        Asset.Source.offline.rawValue)
        if let asset = try? persistentContainer.viewContext.fetch(request).first {
            asset.amount = amount
            print("\(asset.name) updated from offline")
        } else {
            let asset = Asset(context: persistentContainer.viewContext)
            asset.configure(coin, amount: amount)
            print("\(asset.name) created from offline")
        }
        self.saveContext()
    }
    
    //MARK:- Update cmc
    func update(_ cmcCoins: [CMCCoin]) {
        for cmcCoin in cmcCoins {
            let request = Coin.createFetchRequest()
            request.predicate = NSPredicate(format: "name == %@", cmcCoin.name)
            if let coin = try? persistentContainer.viewContext.fetch(request).first {
                coin.update(cmcCoin)
                print("\(coin.name) \(coin.cmcRank) updated")
            } else {
                let coin = Coin(context: persistentContainer.viewContext)
                coin.configure(cmcCoin)
                print("\(coin.name) created")
            }
        }
        
        self.saveContext()
        
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

    func saveContext () {
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
