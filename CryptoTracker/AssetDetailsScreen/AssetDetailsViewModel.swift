//
//  AssetDetailsViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//

import Foundation

struct AssetDetailsViewModel {
    let assetName: String
    var assets: [AssetCellViewModel] {
        SyncCoordinator.shared.getAssets(name: assetName).map({ AssetCellViewModel($0) })
    }
}
