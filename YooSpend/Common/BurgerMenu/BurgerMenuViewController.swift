//
//  BurgerMenuViewController.swift
//  YooSpend
//
//  Created by Artak on 2/4/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

class BurgerMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var burgerMenuNavigation: UINavigationController?

    var dataSource = [BurgerMenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //performSegue(withIdentifier: "BurgerMenuNavigation", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "BurgerMenuNavigation") {
            burgerMenuNavigation = segue.destination  as? UINavigationController
            let navigationItem = burgerMenuNavigation?.navigationItem
            navigationItem?.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_sort_white"), style: .plain, target: self, action: #selector(menuTapped))
            navigationItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_sort_white"), style: .plain, target: self, action: #selector(menuTapped))
            navigationItem?.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_sort_white"), style: .plain, target: self, action: #selector(menuTapped))
            showViewController(for: 0)
        }
    }

    func showViewController(for index: Int) {
        let viewController = MainViewController.initFromStoryboard()
        viewController.view.backgroundColor = UIColor.green
        
        burgerMenuNavigation?.viewControllers = [viewController]
    }

    @objc func menuTapped() {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerMenuCell", for: indexPath) as! BurgerMenuCell
        
        cell.setup(item: dataSource[indexPath.row])
        
        return cell
    }
}
