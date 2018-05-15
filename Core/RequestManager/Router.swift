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
    case put = "PUT"
}

protocol Router {
    var baseUrl: String { get }
    var parameters: [String: Any]? { get }
    var resource: String { get }
    var method: Method { get }
    var localization: String { get }
    var apiVersion: String { get }
    var headers: [String: String] { get }
}


extension Router {
    var baseUrl: String { return "https://69.64.48.15:8445/api/\(apiVersion)/" }
    var parameters: [String: Any]? { return nil }
    var method: Method { return .get }
    var localization: String { return "en/" }
    var apiVersion: String { return "v3" }
    var headers: [String: String] {
        let token = "TODO token"

        return ["Authorization": "Bearer \(token)"]
    }
}
