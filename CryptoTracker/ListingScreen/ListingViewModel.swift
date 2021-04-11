//
//  ViewModel.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

class ListingViewModel {
    var coins = [Coin]()
    let urlString = Enviroment.shared.baseLink + "/v1/cryptocurrency/listings/latest"
    var currentSortOption: ListingResponse.SortOption = .martketCapDesc
    
    func fetchCoins(sort: ListingResponse.SortOption = .martketCapDesc, completion: @escaping (Error?)->()) {
        coins = []
        let queryParams = [
            URLQueryItem(name: "sort", value: sort.getStrings().0),
            URLQueryItem(name: "sort_dir", value: sort.getStrings().1)
        ]
        
        guard let requestGenerator = try? RequestGenerator.init(urlString:urlString, queryParams: queryParams) else {
            print("🚨 something wrong")
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestGenerator.request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("🚨 invalid http response")
                return
            }
            
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let d = data,
                  let model = try? decoder.decode(ListingResponse.self, from: d)
            else {
                print("🚨 invalid data")
                //print(String(data: data!, encoding: .utf8))
                return
            }
            
            if let _ = error {
                print("🚨 some error")
                return
            }
            
            print(httpResponse.statusCode)
            
            if httpResponse.statusCode == 200 {
                self.coins = model.data ?? []
            } else {
                print("🚨 \(model.status.error_message!)")
            }
            
            completion(nil)
        }
        
        task.resume()
    }
}
