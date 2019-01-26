//
//  MainController.swift
//  Happy Jai
//
//  Created by Ken Ho on 26/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
//
//    let tabBarItems: [UITabBarItem] = [
//        UITabBarItem(title: "Chats", image: nil, selectedImage: nil),
//        UITabBarItem(title: "Favourite", image: nil, selectedImage: nil),
//        UITabBarItem(title: "Search", image: nil, selectedImage: nil),
//        UITabBarItem(title: "Account", image: nil, selectedImage: nil),
//        UITabBarItem(title: "Setting", image: nil, selectedImage: nil),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .secondaryColor
        tabBar.tintColor = .secondaryColor

        let chatroomController = ChatroomViewController()
        chatroomController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        let favoritesView = UIViewController()
        favoritesView.view.backgroundColor = .primaryColor
        favoritesView.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let searchView = UIViewController()
        searchView.view.backgroundColor = .primaryColor
        searchView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)

        let settingView = UIViewController()
        settingView.view.backgroundColor = .primaryColor
        settingView.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)

        let tabBarItems = [
            chatroomController,
            favoritesView,
            searchView,
            settingView
        ]

        viewControllers = tabBarItems
    }
}
