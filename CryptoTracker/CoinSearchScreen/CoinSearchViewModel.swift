//
//  CoinSearchViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 19/05/2021.
//

import Foundation

class CoinSearchViewModel {
    typealias Quote = CMCCoin.Quote
    typealias PriceBreakdown = CMCCoin.PriceBreakdown
    
    var data = [CMCCoin]() {
        didSet {
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    var updateUI: (()->())?
    
    func fetchCoin(_ symbol: String) {
        print("fetchCoin")
        let endpoint = CMCEndpoint.quote(symbol: symbol)
        do {
            let requestExecuter = try RequestExecuter<CMCQuoteResponse>(endpoint)
            requestExecuter.executeForData { [weak self] (data, error) in
                print(data)
                guard
                    let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let jsonData = json["data"] as? [String: Any],
                    let jsonData2 = jsonData["FINE"] as? [String: Any],
                    let id = jsonData2["id"] as? Int,
                    let name = jsonData2["name"] as? String,
                    let symbol = jsonData2["symbol"] as? String,
                    let slug = jsonData2["slug"] as? String,
                    let cmc_rank = jsonData2["cmc_rank"] as? Int,
                    let quote = jsonData2["quote"] as? [String: Any],
                    let usd = quote["USD"] as? [String: Any],
                    let price = usd["price"] as? Double,
                    let percent_change_24h = usd["percent_change_24h"] as? Double
                else {
                    print("invalid data")
                    return
                }
                
          
                let coin = CMCCoin(id: id,
                                   name: name,
                                   symbol: symbol,
                                   quote: Quote(USD: PriceBreakdown(price: price,
                                                                    percent_change_24h: percent_change_24h)),
                                   slug: slug,
                                   cmc_rank: cmc_rank)
                self?.data = [coin]
            }
        } catch {
            print(error)
        }
    }
}
