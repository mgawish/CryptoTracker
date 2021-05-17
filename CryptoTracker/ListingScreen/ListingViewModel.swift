//
//  ViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

class ListingViewModel {
    typealias Sort = ListingResponse.SortOption
    var coins: [Coin] {
        SyncCoordinator.shared.getCoins()
    }
    
    var currentSortOption: Sort = .martketCapDesc
    
    func fetchCoins(sort: Sort, completion: @escaping (Error?)->()) {
        let endpoint = CMCEndpoint.listing(sort: sort)
        do {
            let requestExecuter = try RequestExecuter<ListingResponse>(endpoint)
            requestExecuter.execute { [weak self] (model, error) in
                let data = model?.data ?? []
                SyncCoordinator.shared.update(data)
                completion(nil)
            }
        } catch {
            completion(error)
            print(error)
        }
       
    }
}
