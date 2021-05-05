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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        updateUI()
        viewModel.fetchAssets()
    }
    
    func updateUI() {
        totalLabel.text = "$\(viewModel.assetsTotal)"
    }
    
    @IBAction func addAssetTapped(_ sender: Any) {
        
    }
}

extension AssetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell", for: indexPath)
        let asset = viewModel.assets[indexPath.row]
        cell.textLabel?.text = "\(asset.quantity) (\(asset.coin.symbol) - \(asset.value)"
        return cell
    }
    
    
}
