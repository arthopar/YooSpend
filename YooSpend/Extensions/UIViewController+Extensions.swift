//
//  UIViewController+Extensions.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 5/16/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import SwinjectAutoregistration
import Swinject

extension SwinjectStoryboard {
    @objc class func setup() {

        Container.loggingFunction = nil
        injectMainViewController()
    }

    class func injectMainViewController() {
        defaultContainer.storyboardInitCompleted(WalletsViewController.self) { r, c in
            c.viewModel = r.resolve(WalletsViewModel.self)
        }
        defaultContainer.autoregister(DataManagers.self, initializer: DataManagers.init)
        defaultContainer.autoregister(WalletsViewModel.self, initializer: WalletsViewModel.init(dataManagers:))
    }
}

protocol InitFromStoryboard {
    static func initFromStoryboard() -> Self
}

extension UIViewController: InitFromStoryboard {}

extension InitFromStoryboard where Self: UIViewController {
    static func initFromStoryboard() -> Self {
        let bundle = Bundle(for: Self.self)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
    }
}

