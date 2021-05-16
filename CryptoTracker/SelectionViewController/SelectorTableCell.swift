//
//  SelectorTableCell.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//

import UIKit

class SelectorCell: UITableViewCell {
    var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label = UILabel()
        label.text = "-"
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12)
        ])
    }
    
    
}

