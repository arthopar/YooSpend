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

enum Response<T> {
    case error(ServerError)
    case success(T)
}

class TrustedSessionManager: NSObject, URLSessionDelegate {
    lazy var session: URLSession = {[weak self] in
        let configuration = URLSessionConfiguration.default
        
        return URLSession(configuration: configuration,
                          delegate: self,
                          delegateQueue:OperationQueue.main)
        }()
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        let trust = challenge.protectionSpace.serverTrust
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, trust != nil ? URLCredential(trust:trust!) : nil)
    }
}

class RestApiManager {
    let trustedSessionManager = TrustedSessionManager()
    
    public func makeRequest<T: Codable>(parameters: Router, onCompletion: @escaping ((Response<T>) -> Void)) {
        guard let url = URL(string:"\(parameters.baseUrl)\(parameters.resource)\(parameters.localization)") else {
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
        request.addValue("7199d2d4e0242be30e768469d144bf0663c93dc3", forHTTPHeaderField: "Authorization")
        print(url)
        let task = trustedSessionManager.session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            let parser = Parser()
            let responseObject: Response<T>
            do {
                let objectResponse: ResponseDataContainer<T> = try parser.parsData(data: data!)
                if objectResponse.error == true {
                    responseObject = .error(ServerError(stringLiteral: objectResponse.message ?? "Unknown error"))
                } else if let object: T = objectResponse.data {
                    responseObject = .success(object)
                } else {
                    responseObject = .error("Unknown error")
                }
            } catch {
                responseObject = .error(ServerError(error: error))
            }
            
            onCompletion(responseObject)
        })
        
        task.resume()
    }
    
}

