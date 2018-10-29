//
//  BurgerMenuHeaderView.swift
//  YooSpend
//
//  Created by Artak on 2/4/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class BurgerMenuHeaderView: IBDesignableView {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        headerImage.layer.cornerRadius = headerImage.bounds.height / 2
        headerImage.backgroundColor = Theme.Colors.themedText
        nameLabel.textColor = Theme.Colors.themedText
    }
}
