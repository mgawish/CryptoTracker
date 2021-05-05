//
//  NetworkError.swift
//  CryptoTracker
//
//  Created by Gawish on 11/04/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case responseError
    case dataError
}
