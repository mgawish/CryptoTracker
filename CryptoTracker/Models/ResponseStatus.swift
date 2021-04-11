//
//  ResponseStatus.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation

struct ResponseStatus: Codable {
    let timestamp: String
    let error_code: Int?
    let error_message: String?
    
}
