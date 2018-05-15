//
//  RestApiManager.swift
//  YooSpend
//
//  Created by Artak on 12/25/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

final class ServerError: ExpressibleByStringLiteral, Error {
    typealias StringLiteralType = String
    let errorMessage: String
    var code: Int?

    public required init(stringLiteral value: StringLiteralType) {
        errorMessage = value
    }

    public init(error: Error, code: Int?) {
        self.errorMessage = error.localizedDescription
        self.code = code
    }
}

enum Response<T> {
    case error(ServerError)
    case success(T?)
}

final class TrustedSessionManager: NSObject, URLSessionDelegate {
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

final class RestApiManager {
    let trustedSessionManager = TrustedSessionManager()

    public func makeRequest<T: Codable>(parameters: Router, onCompletion: @escaping ((Response<T>) -> Void)) {
        guard let url = URL(string:"\(parameters.baseUrl)\(parameters.resource)\(parameters.localization)") else {
            onCompletion(Response.error(""))

            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = parameters.method.rawValue

        // Set the POST body for the request
        if let params = parameters.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }

        parameters.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(url)
        let task = trustedSessionManager.session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            guard error == nil else {
                onCompletion(Response.error(ServerError(error: error!, code:(error as NSError?)?.code)))

                return
            }

            guard data != nil else {
                onCompletion(Response.error(ServerError(stringLiteral: "Response is empty")))

                return
            }

            let parser = Parser()
            let responseObject: Response<T>
            do {
                let objectResponse: ResponseDataContainer<T> = try parser.parsData(data: data!)
                if objectResponse.error == true {
                    let errorMessage = objectResponse.message ?? "Unknown error!"
                    responseObject = .error(ServerError(stringLiteral: errorMessage))
                } else {
                    responseObject = .success(objectResponse.data)
                }
            } catch {
                print("Parsing error \(error)")
                responseObject = .error(ServerError(error: error, code:0))
            }

            onCompletion(responseObject)
        })

        task.resume()
    }
}

