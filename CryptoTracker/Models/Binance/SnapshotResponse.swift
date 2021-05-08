//
//  SnapshotResponse.swift
//  CryptoTracker
//
//  Created by Gawish on 05/05/2021.
//

import Foundation

struct SnapshotResponse: Codable {
    let code: Int
    let msg: String
    let snapshotVos: [SnapshotVos]
}

extension SnapshotResponse {
    struct SnapshotVos: Codable {
        let type: String
        let updateTime: TimeInterval
        let data: SnapShot
    }
    
    struct SnapShot: Codable {
        let totalAssetOfBtc: String
        let balances: [Balance]
    }
    
    struct Balance: Codable {
        let asset: String
        let free: String
        let locked: String
        
        var displayPrice: Int {
            (Int(free) ?? 0) + (Int(locked) ?? 0)
        }
    }
}
