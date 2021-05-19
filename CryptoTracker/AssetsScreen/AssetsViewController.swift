//
//  AssetsViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 13/04/2021.
//

import UIKit

class AssetsViewController: UIViewController {
    var viewModel = AssetsViewModel()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AssetCell.Identifier, bundle: nil),
                           forCellReuseIdentifier: AssetCell.Identifier)
        
        viewModel.updateUI = updateUI
        viewModel.fetchAssets()
        
        updateSegmentedControl()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavBar()
    }

    func updateNavBar() {
        parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                    target: self,
                                                                    action: #selector(showChoices))
    }
    
    func updateSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "All", at: 0, animated: true)
        for p in viewModel.portfolios {
            segmentedControl.insertSegment(withTitle: p.name, at: 1, animated: true)
        }
    }
    
    func updateUI() {
        totalLabel.text = "$ \(viewModel.usdValue)"
        tableView.reloadData()
    }
    
    
    func addAmount(_ coin: Coin, nc: UINavigationController) {
        if let vc = UIStoryboard(name: "Amounts", bundle: nil).instantiateViewController(identifier: "AmountsViewController") as? AmountsViewController {
            vc.coin = coin
            vc.didUpdate = { [weak self] in
                self?.updateUI()
            }
            nc.pushViewController(vc, animated: true)
        }
    }
    
    @objc func showChoices() {
        let ac = UIAlertController(title: "What would you like to add?", message: nil, preferredStyle: .actionSheet)
        let addAssetAction = UIAlertAction(title: "Add asset", style: .default, handler: segueToAssetSelector)
        let addPortfolioAction = UIAlertAction(title: "Add portfolio", style: .default, handler: segueToPortfolioScreen)

        ac.addAction(addAssetAction)
        ac.addAction(addPortfolioAction)
        present(ac, animated: true, completion: nil)
    }
    
    func segueToAssetDetails(_ asset: AssetCellViewModel) {
        let vc = AssetDetailsViewController()
        vc.assetName = asset.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func segueToAssetSelector(action: UIAlertAction) {
        let vc = SelectorViewController()
        let nc = UINavigationController()
        nc.addChild(vc)
        present(nc, animated: true, completion: nil)
        
        let data = SyncCoordinator.shared.getCoins().map({ $0.symbol })
        vc.data = data
        vc.didSelectValue = { [weak self] value in
            if let coin = SyncCoordinator.shared.getCoins(symbol: value).first {
                self?.addAmount(coin, nc: nc)
            }
        }
    }
    
    func segueToPortfolioScreen(action: UIAlertAction) {
        let vc = AddPortfolioViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.portfolioName = nil
            updateUI()
        } else {
            viewModel.portfolioName = viewModel.portfolios[sender.selectedSegmentIndex-1].name
            updateUI()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asset = viewModel.combinedAssets[indexPath.row]
        segueToAssetDetails(asset)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
