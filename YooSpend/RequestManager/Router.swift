//
//  Router.swift
//  YooSpend
//
//  Created by Artak on 12/25/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

enum Method: String {
    case post = "POST"
    case get = "GET"
}

protocol Router {
    var baseUrl: String { get }
    var parameters: [String: Any]? { get }
    var method: Method { get }
}


extension Router {
    var baseUrl: String { return "https://gooogle.com" }
    var parameters: [String: Any]? { return nil }
    var method: Method { return .get }
}
