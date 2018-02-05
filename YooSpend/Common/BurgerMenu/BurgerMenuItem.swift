//
//  BurgerMenuItem.swift
//  YooSpend
//
//  Created by Artak on 2/4/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class BurgerMenuItem {
    let title: String
    let icon: UIImage
    let viewController: UIViewController
    
    init(title: String, icon: UIImage, viewController: UIViewController) {
        self.title = title
        self.icon = icon
        self.viewController = viewController
    }
}
