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
        
        parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                    target: self,
                                                                    action: #selector(addAsset))
        updateUI()
        viewModel.updateUI = updateUI
        viewModel.fetchAssets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        totalLabel.text = "$ \(viewModel.usdValue)"
        tableView.reloadData()
    }
    
    @objc func addAsset() {
        let vc = SelectorViewController()
        let nc = UINavigationController()
        nc.addChild(vc)
        present(nc, animated: true, completion: nil)
        
        let data = SyncCoordinator.shared.coins.map({ $0.symbol })
        vc.data = data
        vc.didSelectValue = { [weak self] value in
            if let coin = SyncCoordinator.shared.coins.filter({ $0.symbol == value }).first {
                self?.addAmount(coin, nc: nc)
            }
        }
    }
    
    func addAmount(_ coin: CMCCoin, nc: UINavigationController) {
        if let vc = UIStoryboard(name: "Amounts", bundle: nil).instantiateViewController(identifier: "AmountsViewController") as? AmountsViewController {
            vc.coin = coin
            vc.didUpdate = { [weak self] in
                self?.updateUI()
            }
            nc.pushViewController(vc, animated: true)
        }
    }
}

extension AssetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.combinedAssets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetCell.Identifier, for: indexPath) as? AssetCell
        let asset = viewModel.combinedAssets[indexPath.row]
        cell?.configure(asset)
        return cell ?? UITableViewCell()
    }
}
