//
//  EndpointProtocol.swift
//  CryptoTracker
//
//  Created by Gawish on 05/05/2021.
//

import Foundation

protocol EndpointProtocol {
    var baseLink: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var params: [URLQueryItem] { get }
    var headers: [String: String] { get }
}
