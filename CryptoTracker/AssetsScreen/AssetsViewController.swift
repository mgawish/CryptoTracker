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
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AssetCell.Identifier, bundle: nil),
                           forCellReuseIdentifier: AssetCell.Identifier)
        updateUI()
        viewModel.updateUI = updateUI
        viewModel.fetchAssets()
    }
    
    func updateUI() {
        totalLabel.text = "$ \(viewModel.usdValue)"
        tableView.reloadData()
    }
}

extension AssetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetCell.Identifier, for: indexPath) as? AssetCell
        let asset = viewModel.assets[indexPath.row]
        cell?.configure(asset)
        return cell ?? UITableViewCell()
    }
}
