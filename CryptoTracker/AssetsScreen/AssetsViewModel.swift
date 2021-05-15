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
    
    var assets = [Asset]()
    var usdValue: Double {
        assets.map({ $0.price * $0.amount }).reduce(0, +).roundedUpTwoDecimals()
    }
    
    init() {
        self.assets = SyncCoordinator.shared.getAssets()
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
                    self?.assets = SyncCoordinator.shared.getAssets()
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
