//
//  Double+Extension.swift
//  CryptoTracker
//
//  Created by Gawish on 15/05/2021.
//

import Foundation

extension Double {
    func roundedUpTwoDecimals() -> Double {
        100*self.rounded(.up)/100
        //round(.up)
    }
}
