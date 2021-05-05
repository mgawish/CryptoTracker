//
//  ViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

class ListingViewModel {
    typealias Sort = ListingResponse.SortOption
    var coins = [Coin]()
    var currentSortOption: Sort = .martketCapDesc
    
    func fetchCoins(sort: Sort, completion: @escaping (Error?)->()) {
        coins = []
        let endpoint = CMCEndpoint.listing(sort: sort)
        do {
            let requestExecuter = try RequestExecuter<ListingResponse>(endpoint: endpoint)
            try requestExecuter.execute { [weak self] (model, error) in
                self?.coins = model?.data ?? []
                completion(nil)
            }
        } catch {
            completion(error)
            print(error)
        }
       
    }
}
