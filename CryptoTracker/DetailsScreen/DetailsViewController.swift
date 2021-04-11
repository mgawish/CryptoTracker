//
//  DetailsViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    var coin: Coin!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    class func present(coin: Coin, parent: UIViewController) {
        if let vc = parent.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            parent.navigationController?.pushViewController(vc, animated: true)
            vc.coin = coin
            vc.title = coin.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        symbolLabel.text = coin.symbol
        nameLabel.text = coin.name
        priceLabel.text = "$\(coin.displayPrice)"
        changeLabel.text = "%\(coin.displayChange)"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareCoinDetails))
    }
    
    @objc func shareCoinDetails() {
        let activityView = UIActivityViewController(activityItems: [coin.name], applicationActivities: [])
        
        present(activityView, animated: true, completion: nil)
    }
}
