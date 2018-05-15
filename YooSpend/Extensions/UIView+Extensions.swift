//
//  UIView+Extensions.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 5/14/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

protocol Autolayout {
    static func autoLayoutView() -> Self
}

extension Autolayout where Self: UIView {
    static func autoLayoutView() -> Self {
        let view = Self.init()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }
}

extension UIView: Autolayout {}

extension UIView {
    func addSubviewWithInsents(view: UIView, insents: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insents.bottom).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -insents.left).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: insents.right).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: -insents.top).isActive = true
    }
}

extension UIView {
    public static func loadNib() -> UIView {
        let bundle = Bundle.main
        let nibName = self.description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension UIView {
    func addBlur() -> UIVisualEffectView {
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)

        let blurView = UIVisualEffectView()

        UIView.animate(withDuration: 0.2) {
            blurView.effect = darkBlur
        }

        self.addSubviewWithInsents(view: blurView)

        return blurView
    }
}
