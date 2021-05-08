//
//  TableCell.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import UIKit

class ListingCell: UITableViewCell {
    static let identifier = "ListingCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    func configure(coin: CMCCoin) {
        nameLabel.text = coin.symbol
        priceLabel.text = "\(coin.displayPrice)"
        changeLabel.text = "\(coin.displayChange)%"
        changeLabel.textColor = coin.displayChange > 0 ? .green : .red
    }
}
