//
//  Navigation.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 5/22/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

protocol Destination {}

protocol Navigation {
    var source: UIViewController? { get }
    init(source: UIViewController)

    func navigate(to destination: Destination)
}
