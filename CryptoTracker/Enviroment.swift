//
//  Enviroment.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

class Enviroment {
    static let shared = Enviroment()
    let baseLink: String
    let cmcApiKey: String
    
    init() {
        baseLink = Bundle.main.infoDictionary?["BASE_LINK"] as? String ?? ""
        cmcApiKey = Bundle.main.infoDictionary?["CMC_API_KEY"] as? String ?? ""
    }
}
