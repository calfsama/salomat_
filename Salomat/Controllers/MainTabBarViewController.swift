//
//  MainTabBarViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 28/11/22.
//

import UIKit
import SwiftKeychainWrapper
import KeychainAccess

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor =  UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let home = MainViewController()
        let homeNavigation = UINavigationController(rootViewController: home)
        let homeItem = TabBarItem(title: "Главная", image: UIImage(named: "logo1"), selectedImage: UIImage(named: "mainpage")?.withRenderingMode(.alwaysOriginal))
        homeNavigation.tabBarItem = homeItem
        
        let favorite = FavoritesViewController()
        let favoriteNavigation = UINavigationController(rootViewController: favorite)
        let favoriteItem = TabBarItem(title: "Избранное", image: UIImage(named: "iconHeart"), selectedImage: UIImage(named: "favoritepage")?.withRenderingMode(.alwaysOriginal))
       
        favoriteNavigation.tabBarItem = favoriteItem
        
        let receipt = ReceiptViewController()
        let receiptNavigation = UINavigationController(rootViewController: receipt)
        let receiptItem = TabBarItem(title: "е-рецепт", image: UIImage(named: "camera"), selectedImage: UIImage(named: "ereceiptpage")?.withRenderingMode(.alwaysOriginal))
        receiptNavigation.tabBarItem = receiptItem
        
        let cart = CartViewController()
        let cartNavigation = UINavigationController(rootViewController: cart)
        let cartItem = TabBarItem(title: "Корзина", image: UIImage(named: "trash can"), selectedImage: UIImage(named: "cartpage")?.withRenderingMode(.alwaysOriginal))
        cartNavigation.tabBarItem = cartItem
        
        let profile = ProfileViewController()
        let profileNavigation = UINavigationController(rootViewController: profile)
        let profileItem = TabBarItem(title: "Профиль", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profilepage")?.withRenderingMode(.alwaysOriginal))
        profileNavigation.tabBarItem = profileItem
        
        let profilePage = ProfileInfoViewController()
        let profilePageNavigation = UINavigationController(rootViewController: profilePage)
        let profilePageItem = TabBarItem(title: "Профиль", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profilepage")?.withRenderingMode(.alwaysOriginal))
        profilePageNavigation.tabBarItem = profilePageItem
        
        let token = KeychainWrapper.standard.string(forKey: "ttoken")
        if token != nil {
            viewControllers = [homeNavigation, favoriteNavigation, receiptNavigation, cartNavigation, profilePageNavigation]
            //selectedIndex = 4
        }
        else if token == nil {
            viewControllers = [homeNavigation, favoriteNavigation, receiptNavigation, cartNavigation, profileNavigation]
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected \(viewController.title!)")
    }
}
