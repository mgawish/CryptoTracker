//
//  AssetsViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 13/04/2021.
//

import UIKit

class AssetsViewController: UIViewController {
    var viewModel = AssetsViewModel()
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        updateUI()
        viewModel.updateUI = updateUI
        viewModel.fetchAssets()
    }
    
    func updateUI() {
        if let total = viewModel.totalInBtc {
            totalLabel.text = "\(total) BTC"
            dateLabel.text = "\(viewModel.snapTime)"
        } else {
            totalLabel.text = "- BTC"
            dateLabel.text = "-"
        }
        tableView.reloadData()
    }
}

extension AssetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.assets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell", for: indexPath)
        if let balance = viewModel.assets?[indexPath.row] {
            cell.textLabel?.text =  "\(balance.asset) \(balance.free)"
        } else {
            cell.textLabel?.text =  "-"
        }
        
        return cell
    }
}
