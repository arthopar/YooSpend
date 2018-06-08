//
//  NavigationController.swift
//  YooSpend
//
//  Created by Artak on 2/3/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationBar.barTintColor = Theme.Colors.main
        self.navigationBar.tintColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
