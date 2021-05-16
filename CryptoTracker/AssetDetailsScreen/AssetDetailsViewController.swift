//
//  AssetDetailsScreen.swift
//  CryptoTracker
//
//  Created by Gawish on 16/05/2021.
//

import UIKit

class AssetDetailsViewController: UIViewController {
    var assetName: String = ""
    lazy var viewModel = AssetDetailsViewModel(assetName: assetName)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: AssetCell.Identifier, bundle: nil), forCellReuseIdentifier: AssetCell.Identifier)
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension AssetDetailsViewController: UITableViewDelegate, UITableViewDataSource {
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
