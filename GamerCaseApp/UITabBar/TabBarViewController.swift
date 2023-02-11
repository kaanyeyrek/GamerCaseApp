//
//  TabBarViewController.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import UIKit

class TabBarViewController: UITabBarController {
// set two tab
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    private func setupVC() {
        let gamesVC = HomeViewController()
        let favoritesVC = FavoritesViewController()
        
        let gamesNav = UINavigationController(rootViewController: gamesVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        
        gamesVC.title = "Games"
        favoritesVC.title = "Favourites"
        
        gamesNav.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: Constants.gameTabIcon), tag: 0)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: Constants.starTabIcon), tag: 1)
        
        setViewControllers([gamesNav, favoritesNav], animated: true)
    }
}
