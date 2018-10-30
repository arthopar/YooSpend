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
    @IBOutlet weak var menuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var semitransparentView: UIView!
    @IBOutlet weak var gestureScreenEdgePan: UIScreenEdgePanGestureRecognizer!

    private var burgerMenuNavigation: UINavigationController?

    private let maxBlackViewAlpha: CGFloat = 0.5
    private let animationDuration: TimeInterval = 0.3

    let viewModel = BurgerMenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()

        menuLeadinConstraint.constant = -tableView.frame.width
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "BurgerMenuNavigation") {
            burgerMenuNavigation = segue.destination  as? UINavigationController

            showViewController(for: 0)

            let navigationItem = burgerMenuNavigation?.viewControllers.first?.navigationItem
            navigationItem?.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_sort_white"), style: .plain, target: self, action: #selector(menuTapped))
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
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let data = viewModel.dataSource[indexPath.row]

        showViewController(for: data.destination.rawValue)
    }

    @IBAction func gestureScreenEdgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            semitransparentView.alpha = 0
        } else if (sender.state == UIGestureRecognizer.State.changed) {
            let translationX = sender.translation(in: sender.view).x

            if -menuWidthConstraint.constant + translationX > 0 {
                updateBurgerMenu(shouldShow: true)
            } else if translationX < 0 {
                updateBurgerMenu(shouldShow: false)
            } else {
                menuLeadinConstraint.constant = -menuWidthConstraint.constant + translationX
                let ratio = translationX / menuWidthConstraint.constant
                let alphaValue = ratio * maxBlackViewAlpha
                semitransparentView.alpha = alphaValue
            }
        } else {
            let shouldShow = menuLeadinConstraint.constant > -menuWidthConstraint.constant / 2
            self.updateBurgerMenu(shouldShow: shouldShow)
        }
    }

    @IBAction func gesturePan(_ sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.changed {
            let translationX = sender.translation(in: sender.view).x

            if translationX > 0 {
                updateBurgerMenu(shouldShow: true)
            } else if translationX < -menuWidthConstraint.constant {
                updateBurgerMenu(shouldShow: false)
            } else {
                menuLeadinConstraint.constant = translationX
                let ratio = (menuWidthConstraint.constant + translationX) / menuWidthConstraint.constant
                let alphaValue = ratio * maxBlackViewAlpha
                semitransparentView.alpha = alphaValue
            }
        } else if sender.state == UIGestureRecognizer.State.ended {
            let shouldShow = menuLeadinConstraint.constant > -menuWidthConstraint.constant / 2
            self.updateBurgerMenu(shouldShow: shouldShow)
        }
    }

    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        self.updateBurgerMenu(shouldShow: false)
    }

    @objc func menuTapped() {
        updateBurgerMenu(shouldShow: true)
    }

    private func updateBurgerMenu(shouldShow: Bool) {
        UIView.animate(withDuration: animationDuration, animations: {[weak self] in
            guard let `self` = self else { return }
            if shouldShow {
                self.semitransparentView.alpha = self.maxBlackViewAlpha
                self.menuLeadinConstraint.constant = 0
            } else {
                self.semitransparentView.alpha = 0
                self.menuLeadinConstraint.constant = -self.tableView.frame.width
            }
            self.view.layoutSubviews()
        }) { c in
            //self.semitransparentView.isHidden = !shouldShow
        }
    }
}
