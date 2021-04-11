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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(sortList))
        
        fetchCoins()
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
        DetailsViewController.present(coin: coin, parent: self)
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let coin = viewModel.coins[indexPath.row]
        cell.textLabel?.text = "\(coin.name) - $\(coin.displayPrice)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueToDetails(coin: viewModel.coins[indexPath.row])
    }
}
