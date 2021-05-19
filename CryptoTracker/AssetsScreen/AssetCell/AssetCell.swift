//
//  AssetCell.swift
//  CryptoTracker
//
//  Created by Gawish on 15/05/2021.
//

import UIKit

class AssetCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sourcesLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    func configure(_ asset: AssetCellViewModel) {
        nameLabel.text = asset.name
        priceLabel.text = "$\(asset.price)"
        amountLabel.text = "\(asset.amount)"
        
        let value = asset.price * asset.amount
        valueLabel.text = "$\(value.roundedUpTwoDecimals())"
        sourcesLabel.text = asset.sources.map({ $0.capitalized }).joined(separator: " ")
        
        if let percentage = asset.percentage {
            percentLabel.text = "\((percentage * 100).roundedUpTwoDecimals())%"
        } else {
            percentLabel.text = ""

        }
        percentLabel.isHidden = asset.percentage == nil
        
    }
}
