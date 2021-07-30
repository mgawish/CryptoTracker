//
//  CoinSearchViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 19/05/2021.
//

import UIKit

class CoinSearchViewController: UIViewController {
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var viewModel = CoinSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.updateUI = updateUI
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.Identifier)
        
        searchBar = UISearchBar()
        searchBar.delegate = self

        let stackView = UIStackView(arrangedSubviews: [searchBar, tableView])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
}

extension CoinSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.Identifier, for: indexPath)
        let coin = viewModel.data[indexPath.row]
        cell.textLabel?.text = "\(coin.name) (\(coin.symbol))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.data[indexPath.row]
        SyncCoordinator.shared.update(coin)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension CoinSearchViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            viewModel.fetchCoin(text)
        }
    }
}
