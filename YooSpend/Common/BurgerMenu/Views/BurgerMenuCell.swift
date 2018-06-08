//
//  BurgerMenuCell.swift
//  YooSpend
//
//  Created by Artak on 2/4/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

class BurgerMenuCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }

    func setup(item: BurgerMenuData) {
        titleLabel.text = item.title
        iconImageView.image = item.icon
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        contentView.backgroundColor =  highlighted ? Theme.Colors.burgerMenuCellSelectedBackground : UIColor.clear
        iconImageView.tintColor = highlighted ? UIColor.white : Theme.Colors.themedText
        titleLabel.textColor = highlighted ? UIColor.white : Theme.Colors.themedText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        contentView.backgroundColor =  selected ? Theme.Colors.burgerMenuCellSelectedBackground : UIColor.clear
        iconImageView.tintColor = selected ? UIColor.white : Theme.Colors.themedText
        titleLabel.textColor = selected ? UIColor.white : Theme.Colors.themedText
    }
}
