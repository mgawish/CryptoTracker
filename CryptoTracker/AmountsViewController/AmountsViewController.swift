//
//  AmountsViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//

import UIKit

class AmountsViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var coin: CMCCoin?
    var amount = 0.0 {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.becomeFirstResponder()
        amountTextField.keyboardType = .decimalPad
        amountTextField.delegate = self
        updateUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveAsset))
    }
    
    func updateUI() {
        guard let coin = coin else { return }
        priceLabel.text = "Price: $\(coin.displayPrice)"
        valueLabel.text = "Value: \(amount * coin.displayPrice)"
    }
    
    @objc func saveAsset() {
        guard let coin = coin else { return }
        SyncCoordinator.shared.update(coin, amount: amount)
    }
}

extension AmountsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        amount = Double(text) ?? 0
    }
}
