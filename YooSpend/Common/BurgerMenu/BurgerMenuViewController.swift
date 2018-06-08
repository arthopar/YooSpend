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
    @IBOutlet weak var menuLeadinConstraint: NSLayoutConstraint!
    @IBOutlet weak var semitransparentView: UIView!
    
    var burgerMenuNavigation: UINavigationController?

    let headerView = BurgerMenuHeaderView.loadNib()
    let viewModel = BurgerMenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        menuLeadinConstraint.constant = -tableView.frame.width
        semitransparentView.isHidden = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuTapped))
        semitransparentView.isUserInteractionEnabled = true
        semitransparentView.addGestureRecognizer(gestureRecognizer)
        semitransparentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02377300613)

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        headerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        tableView.tableHeaderView = headerView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.reloadData()
        tableView.sizeHeaderToFit()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "BurgerMenuNavigation") {
            burgerMenuNavigation = segue.destination  as? UINavigationController

            showViewController(for: 0)

            let navigationItem = burgerMenuNavigation?.viewControllers.first?.navigationItem
            navigationItem?.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_sort_white"), style: .plain, target: self, action: #selector(menuTapped))
        }
    }

    @objc func menuTapped() {
        let souldShow = menuLeadinConstraint.constant != 0


        UIView.animate(withDuration: 0.5, animations: {[weak self] in
            if souldShow {
                self?.semitransparentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
                self?.semitransparentView.isHidden = false
                self?.menuLeadinConstraint.constant = 0
            } else {
                self?.semitransparentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02377300613)
                self?.menuLeadinConstraint.constant = -(self?.tableView.frame.width ?? 0)
            }
            self?.view.layoutSubviews()
        }) { c in
            self.semitransparentView.isHidden = !souldShow
        }
    }

    func showViewController(for index: Int) {
        let viewController = WalletsViewController.initFromStoryboard()
        burgerMenuNavigation?.setViewControllers([viewController], animated: false)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerMenuCell", for: indexPath) as! BurgerMenuCell

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let data = viewModel.dataSource[indexPath.row]

        guard let cell = cell as? BurgerMenuCell else { return }
        cell.setup(item: data)
        if data.isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let data = viewModel.dataSource[indexPath.row]
        showViewController(for: data.destination.rawValue)
    }
}
