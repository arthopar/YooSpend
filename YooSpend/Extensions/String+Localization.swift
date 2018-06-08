//
//  String+Localization.swift
//  YooSpend
//
//  Created by Artak on 2/3/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

extension String {
    static func localized(for key: String, replaceValue comment: String) -> String {
        let fallbackLanguage = "en"
        let fallbackBundlePaths = Bundle.main.path(forResource: fallbackLanguage, ofType: "lproj")

        guard let fallbackBundlePath = fallbackBundlePaths else { return key }

        let fallbackBundle = Bundle(path: fallbackBundlePath)
        let fallbackString = fallbackBundle?.localizedString(forKey: key, value: comment, table: nil)
        let localizedString = Bundle.main.localizedString(forKey: key, value: fallbackString, table: nil)
        
        return localizedString
    }
    
    var localized: String {
        return String.localized(for: self, replaceValue: "")
    }
}
