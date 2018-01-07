//
//  RestApiManager.swift
//  YooSpend
//
//  Created by Artak on 12/25/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

class ServerError: ExpressibleByStringLiteral, Error {
    typealias StringLiteralType = String
    let errorMessage: String

    public required init(stringLiteral value: StringLiteralType) {
        errorMessage = value
    }
    
    public init(error: Error) {
        errorMessage = error.localizedDescription
    }
}

enum Response<T: Decodable> {
    case error(ServerError)
    case success(T)
}

class RestApiManager {
    private func makeRequest<T>(parameters: Router, onCompletion: @escaping ((Response<T>) -> Void)) {
        guard let url = URL(string: parameters.baseUrl) else {
            onCompletion(Response.error(""))
            
            return
        }

        var request = URLRequest(url: url)
        
        // Set the method to POST
        request.httpMethod = parameters.method.rawValue
        
        // Set the POST body for the request
        if let params = parameters.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            let parser = Parser()
            let responseObject: Response<T>
            do {
                let object: T = try parser.parsData(data: data!)
                responseObject = .success(object)
            } catch {
                responseObject = .error(ServerError(error: error))
            }

            onCompletion(responseObject)
        })

        task.resume()
    }
}
