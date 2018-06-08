//
//  FeedTableViewModel.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 6/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit
import Core

struct FeedTableViewModel {
    let icon: UIImageView
    let amount: Double
    let currency: Currency
    let walletName: String
    let lastUpdate: Date
    let categoryName: String
}
