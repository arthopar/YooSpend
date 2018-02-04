//
//  UIViewController+ActivityLoading.swift
//  YooSpend
//
//  Created by Artak on 2/3/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

protocol ActivityLoading: class {
    var activityIndicator: UIView? { get set }
}

extension ActivityLoading where Self: UIViewController {
    func showLoader() {
        if activityIndicator == nil {
            let backgroundView = UIView()
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            self.view.insertSubview(backgroundView, at: 1000)
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundView.backgroundColor = UIColor.clear
            
            
            let loader = UIView()
            loader.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview(loader)
            loader.heightAnchor.constraint(equalToConstant: 80).isActive = true
            loader.widthAnchor.constraint(equalToConstant: 80).isActive = true
            loader.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
            loader.layer.cornerRadius = 10
            loader.backgroundColor = UIColor(white: 0, alpha: 0.4)
            let activity = UIActivityIndicatorView()
            activity.translatesAutoresizingMaskIntoConstraints = false
            loader.addSubview(activity)
            activity.centerXAnchor.constraint(equalTo: loader.centerXAnchor).isActive = true
            activity.centerYAnchor.constraint(equalTo: loader.centerYAnchor).isActive = true
            activity.startAnimating()
            
            self.activityIndicator = backgroundView
        }
        
        activityIndicator?.isHidden = false
    }
    
    func hideLoader() {
        activityIndicator?.isHidden = true
    }
}

