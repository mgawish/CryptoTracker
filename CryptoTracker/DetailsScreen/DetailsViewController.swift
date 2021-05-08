//
//  DetailsViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    var coin: CMCCoin!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    class func present(coin: CMCCoin, parent: UIViewController) {
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addToFavorites))
    }
    
    @objc func addToFavorites() {
        
    }
    
    
}
