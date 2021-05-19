//
//  AddPortfolioScreen.swift
//  CryptoTracker
//
//  Created by Gawish on 18/05/2021.
//

import UIKit

class AddPortfolioViewController: UIViewController {
    var tableView: UITableView!
    var textField: UITextField!
    var assets: [AssetCellViewModel] {
        SyncCoordinator.shared.getAssets().map({ AssetCellViewModel($0, sources: []) })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigation()
    }
    
    func setup() {
        view.backgroundColor = .systemBackground
        textField = CustomTextField()
        textField.borderStyle = .none
        textField.placeholder = "Portfolio Name"
        
        tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AssetCell.Identifier, bundle: nil),
                           forCellReuseIdentifier: AssetCell.Identifier)
        
      
        let stackView = UIStackView(arrangedSubviews: [textField, tableView])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(savePortfolio))
    }
    
    @objc func savePortfolio() {
        guard let name = textField.text,
              let selectedIndexes = tableView.indexPathsForSelectedRows,
              !name.isEmpty
              else {
                print("name missing")
                return
        }
        let selected = selectedIndexes.map({ $0.row }).map({ assets[$0] })
        SyncCoordinator.shared.update(selected, portfolioName: name)
        navigationController?.popViewController(animated: true)
    }
}


extension AddPortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetCell.Identifier, for: indexPath) as? AssetCell
        cell?.configure(assets[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
