//
//  FeedTableViewCell.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 6/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var walletNameLabel: UILabel!

    func setup(model: FeedTableViewModel) {
        iconImageView.image = model.icon

        amountLabel.text = "\(model.amount.toString()) \(model.currency.rawValue)"
        amountLabel.textColor = model.amount > 0 ? Theme.Colors.positiveText : Theme.Colors.negativeText

        titleLabel.text = model.title
    }
}
