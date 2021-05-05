//
//  MainViewController.swift
//  CryptoTracker
//
//  Created by Gawish on 13/04/2021.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listingStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        let listingViewController = listingStoryboard.instantiateViewController(identifier: "ListingViewController")
        listingViewController.tabBarItem = UITabBarItem(title: "Coins",
                                                        image: UIImage(systemName: "bitcoinsign.circle"),
                                                        tag: 0)
        listingViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                                for: .selected)
        
        let assetStoryboard =  UIStoryboard(name: "Assets", bundle: nil)
        let assetViewController = assetStoryboard.instantiateViewController(identifier: "AssetsViewController")
        assetViewController.tabBarItem = UITabBarItem(title: "Assets",
                                                      image: UIImage(systemName: "bag"),
                                                      tag: 1)
        listingViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                                for: .selected)
        
        tabBar.tintColor = .white
        
        viewControllers = [listingViewController, assetViewController]
    }
}
