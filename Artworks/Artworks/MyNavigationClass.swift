//
//  MyNavigationClass.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 25/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import Foundation
import UIKit



class MyNavigationClass {
    
    func setUpNavigation() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let entryVC = mainStoryBoard.instantiateViewController(withIdentifier: "ArtTableViewController")
        
        let navigationController = UINavigationController(rootViewController: entryVC)
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        
        let newViewController = mainStoryBoard.instantiateViewController(withIdentifier: "CollectionViewController")
        let collectionNavigationController = UINavigationController(rootViewController: newViewController)

//        guard let newVC = newViewController else {
//            tabBarController.viewControllers = [navigationController]
//            print("----failed to instantiate second ViewController")
//            return tabBarController
//        }
        
        collectionNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        tabBarController.viewControllers = [navigationController,collectionNavigationController]
        
        return tabBarController
    }
    
    
}
