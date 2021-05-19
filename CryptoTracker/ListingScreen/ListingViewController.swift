//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 10/04/2021.
//

import UIKit

class ListingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ListingCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ListingCell.identifier)
        fetchCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavBar()
    }
    
    func updateNavBar() {
        parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down.circle"),
            style: .plain,
            target: self,
            action: #selector(sortList))
        
    }
    
    func fetchCoins(sort: ListingResponse.SortOption = .martketCapDesc) {
        viewModel.fetchCoins(sort: sort) { (error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                print("reload")
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    @objc func sortList() {
        let sheet = UIAlertController(title: "Sort", message: "", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Name Ascending", style: .default, handler: sortSelected))
        sheet.addAction(UIAlertAction(title: "Name Descending", style: .default, handler: sortSelected))
        sheet.addAction(UIAlertAction(title: "Market Cap Ascending", style: .default, handler: sortSelected))
        sheet.addAction(UIAlertAction(title: "Market Cap Descending", style: .default, handler: sortSelected))
        present(sheet, animated: true, completion: nil)
    }
    
    func sortSelected(action: UIAlertAction) {
        var sort: ListingResponse.SortOption
        switch action.title {
        case "Name Ascending":
            sort = .nameAsc
        case "Name Descending":
            sort = .nameDesc
        case "Market Cap Ascending":
            sort = .marketCapAsc
        case "Market Cap Descending":
            sort = .martketCapDesc
        default:
            sort = .martketCapDesc
        }
        
        fetchCoins(sort: sort)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func segueToDetails(coin: Coin) {
        WebViewController.present(urlString: "https://coinmarketcap.com/currencies/\(coin.slug)", parent: self)
        //DetailsViewController.present(coin: coin, parent: self)
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingCell.identifier, for: indexPath) as? ListingCell
        let coin = viewModel.coins[indexPath.row]
        cell?.configure(coin: coin)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueToDetails(coin: viewModel.coins[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
