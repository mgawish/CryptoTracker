//
//  Enviroment.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

class Enviroment {
    static let shared = Enviroment()
    let cmcBaseLink: String
    let cmcApiKey: String
    let binanceBaseLink: String
    let binanceApiKey: String
    let binanceApiSecret: String
    
    init() {
        cmcBaseLink = Bundle.main.infoDictionary?["CMC_BASE_LINK"] as? String ?? ""
        cmcApiKey = Bundle.main.infoDictionary?["CMC_API_KEY"] as? String ?? ""
        
        binanceBaseLink = Bundle.main.infoDictionary?["BINANCE_BASE_LINK"] as? String ?? ""
        binanceApiKey = Bundle.main.infoDictionary?["BINANCE_API_KEY"] as? String ?? ""
        binanceApiSecret = Bundle.main.infoDictionary?["BINANCE_API_SECRET"] as? String ?? ""
    }
}
