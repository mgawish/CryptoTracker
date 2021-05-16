//
//  SelectorViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 15/05/2021.
//

import UIKit

class SelectorViewController: UIViewController {
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var filteredData = [String]()
    var data = [String]() {
        didSet {
            filteredData = data
        }
    }
    var didSelectRow: ((Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    func filterData(_ text: String) {
        if text.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter({ $0.lowercased().contains(text.lowercased()) })
        }
        tableView.reloadData()
    }
}

extension SelectorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.Identifier, for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row].description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(indexPath.row)
    }
}

extension SelectorViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filterData(searchText)
    }
}
