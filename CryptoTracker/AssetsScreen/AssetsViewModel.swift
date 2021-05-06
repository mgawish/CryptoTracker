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
    
    var response: SnapshotResponse?
    
    var assets: [SnapshotResponse.Balance]? {
        response?.snapshotVos.last?.data.balances
    }
    
    var totalInBtc: String? {
        response?.snapshotVos.last?.data.totalAssetOfBtc
    }
    
    var snapTime: String {
        let updateTime = response?.snapshotVos.last?.updateTime ?? 0
        return "\(Date(timeIntervalSince1970: updateTime/1000))"
    }
    
    func fetchAssets() {
        fetchTime()
    }
    
    private func fetchTime() {
        let endpoint = BinanceEndpoint.serverTime
        do {
            let executer = try RequestExecuter<ServerTimeResponse>(endpoint)
            try executer.execute(completion: { [weak self] (model, _) in
                if let time = model?.serverTime {
                    self?.fetchSnapshot(timestamp: time)
                }
            })
        } catch {
            print(error)
        }
    }
    
    private func fetchSnapshot(timestamp: Int) {
        let signature = generateSignture(endpoint: BinanceEndpoint.snapshot(timestamp: "\(timestamp)",
                                                                            signature: nil))

        let endpoint = BinanceEndpoint.snapshot(timestamp: "\(timestamp)", signature: signature)
        
        do {
            let executer = try RequestExecuter<SnapshotResponse>(endpoint)
            executer.execute(completion: { [weak self] (model, error) in
                if let error = error {
                    print(error)
                } else {
                    self?.response = model
                    self?.printAllDates()
                    DispatchQueue.main.async {
                        self?.updateUI?()
                    }
                }
                
            })
        } catch {
            print(error)
        }
    }
    
    func generateSignture(endpoint: EndpointProtocol) -> String {
        let urlString = endpoint.baseLink + endpoint.path
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = endpoint.params
        return urlComponents?.url?.query?.digest(.sha256, key: Enviroment.shared.binanceApiSecret) ?? ""
    }
    
    func printAllDates() {
        response?.snapshotVos.forEach({ print(Date(timeIntervalSince1970: $0.updateTime/1000)) })
    }
}
