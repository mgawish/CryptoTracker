//
//  AssetsViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 13/04/2021.
//

import UIKit
import SwiftCrypto

class AssetsViewModel {
    var updateUI: (()->())?
    var response: BinanceAccount?
    var portfolioName: String?
    var usdValue: Double {
        combinedAssets.map({ $0.price * $0.amount }).reduce(0, +).roundedUpTwoDecimals()
    }

    var portfolios: [Portfolio] {
        SyncCoordinator.shared.getPortfolios()
    }
    
    var assets: [Asset] {
        if let portfolioName = portfolioName {
            return SyncCoordinator.shared.getAssets(from: portfolioName)
        } else {
            return SyncCoordinator.shared.getAssets()
        }
    }
    
    var combinedAssets: [AssetCellViewModel] {
        var combinedAssets = [AssetCellViewModel]()
        assets.forEach({ asset in
            if let index = combinedAssets.firstIndex(where: { $0.name == asset.name }) {
                combinedAssets[index].amount += asset.amount
                if !combinedAssets[index].sources.contains(asset.source) {
                    combinedAssets[index].sources.append(asset.source)
                }
            } else {
                let combinedAsset = AssetCellViewModel(asset, sources: [asset.source])
                combinedAssets.append(combinedAsset)
            }
        })
        
        let total = combinedAssets.map({ $0.price * $0.amount }).reduce(0, +).roundedUpTwoDecimals()
        combinedAssets.enumerated().forEach { (index, element) in
            let value = element.price * element.amount
            combinedAssets[index].percentage = value / total
        }
            
        return combinedAssets
    }
    
    
    func fetchAssets() {
        fetchTime()
    }
    
    private func fetchTime() {
        let endpoint = BinanceEndpoint.serverTime
        do {
            let executer = try RequestExecuter<ServerTimeResponse>(endpoint)
            executer.execute(completion: { [weak self] (model, _) in
                if let time = model?.serverTime {
                    self?.fetchSnapshot(timestamp: time)
                }
            })
        } catch {
            print(error)
        }
    }
    
    private func fetchSnapshot(timestamp: Int) {
        let endpoint = BinanceEndpoint.account(timestamp: "\(timestamp)")
        
        do {
            let executer = try RequestExecuter<BinanceAccount>(endpoint)
            executer.execute(completion: { [weak self] (model, error) in
                if let error = error {
                    print(error)
                } else {
                    self?.response = model
                    SyncCoordinator.shared.udpate(self?.response?.balances ?? [])
                    DispatchQueue.main.async {
                        self?.updateUI?()
                    }
                }
            })
        } catch {
            print(error)
        }
    }
}
