//
//  CMCQuoteResponse.swift
//  CryptoTracker
//
//  Created by Gawish on 19/05/2021.
//

import Foundation

struct CMCQuoteResponse: Codable {
    let data: [String: [String: CMCCoin]]
    let status: ResponseStatus
}
