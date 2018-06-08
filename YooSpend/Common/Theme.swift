//
//  Theme.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 5/15/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    struct Colors {
        static var main: UIColor { return #colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.2392156863, alpha: 1)}
        static var secondary: UIColor { return #colorLiteral(red: 0.231372549, green: 0.2549019608, blue: 0.368627451, alpha: 1)}

        static var primaryLabel: UIColor { return #colorLiteral(red: 0.231372549, green: 0.2549019608, blue: 0.368627451, alpha: 1)}
        static var secondaryLabel: UIColor { return #colorLiteral(red: 0.231372549, green: 0.2549019608, blue: 0.368627451, alpha: 1)}

        static var background: UIColor { return #colorLiteral(red: 0.231372549, green: 0.2549019608, blue: 0.368627451, alpha: 1)}
        static var separator: UIColor { return #colorLiteral(red: 0.231372549, green: 0.2549019608, blue: 0.368627451, alpha: 1)}

        static var themedText: UIColor { return #colorLiteral(red: 0.1176470588, green: 0.5333333333, blue: 0.8980392157, alpha: 1) }
        static var burgerMenuCellSelectedBackground: UIColor { return #colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1) }
    }

    struct Fonts {
        static var primaryLabel: UIFont { return UIFont.systemFont(ofSize: 14)}
        static var secondaryLabel: UIFont { return UIFont.systemFont(ofSize: 14)}
    }
}
