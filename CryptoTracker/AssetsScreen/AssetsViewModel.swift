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
    
    var response: AccountResponse?
    
    var assets: [AccountResponse.Balance]? {
        return response?.balances.filter({ $0.displayAmount != 0 })
    }
    
    var totalInBtc: String? {
        "-"//response?.snapshotVos.last?.data.totalAssetOfBtc
    }
    
    var snapTime: String {
        let updateTime = response?.updateTime ?? 0
        return "\(Date(timeIntervalSince1970: updateTime/1000))"
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
            let executer = try RequestExecuter<AccountResponse>(endpoint)
            executer.execute(completion: { [weak self] (model, error) in
                if let error = error {
                    print(error)
                } else {
                    self?.response = model
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
