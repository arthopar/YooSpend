//
//  BurgerMenuViewModel.swift
//  YooSpend
//
//  Created by Artak on 2/4/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class BurgerMenuViewModel {
    var dataSource = [BurgerMenuData]()

    init() {
        setupDataSource()
    }

    func setupDataSource() {
        dataSource = [
            BurgerMenuData(title: "About".localized, icon: #imageLiteral(resourceName: "about"), destination: .about, isSelected: false),
            BurgerMenuData(title: "Wallets".localized, icon: #imageLiteral(resourceName: "wallets"), destination: .wallets, isSelected: true),
            BurgerMenuData(title: "Settings".localized, icon: #imageLiteral(resourceName: "settings"), destination: .settings, isSelected: false),
            BurgerMenuData(title: "Privacy".localized, icon: #imageLiteral(resourceName: "privacy"), destination: .privacy, isSelected: false),
            BurgerMenuData(title: "Logout".localized, icon: #imageLiteral(resourceName: "logout"), destination: .logout, isSelected: false)
        ]
    }
}
