//
//  Currency.swift
//  Core
//
//  Created by Artak Tsatinyan on 6/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

public enum Currency: String {
    case euro

    public func sing() -> String {
        switch self {
        case .euro:
            return "€"
        }
    }
}
