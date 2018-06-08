//
//  BurgerMenuItem.swift
//  YooSpend
//
//  Created by Artak on 2/4/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

enum BurgerMenuItem: Int {
    case about
    case wallets
    case settings
    case privacy
    case logout
}

struct BurgerMenuData {
    let title: String
    let icon: UIImage
    let destination: BurgerMenuItem
    var isSelected: Bool
}
