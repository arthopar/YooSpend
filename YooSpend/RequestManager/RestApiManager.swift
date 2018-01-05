//
//  RestApiManager.swift
//  YooSpend
//
//  Created by Artak on 12/25/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

enum Response<T: Decodable> {
    case error(Error)
    case success(T)
}

class RestApiManager {
    private func makeRequest<T>(parameters: Router, onCompletion: ((Response<T>) -> Void)) {
        var err: NSError?
        let request = NSMutableURLRequest(url: URL(string: parameters.baseUrl)!)
        
        // Set the method to POST
        request.httpMethod = parameters.method.rawValue
        
        // Set the POST body for the request
        request.HTTPBody = JSONSerialization.dataWithJSONObject(parameters.parameters, options: nil)
        
        guard let error == err else {
            onCompletion(.error(error))
            
            return
        }

        let session = bURLSession.sharedSession()
        
        let response: Response<T>
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let parser = Parser()
            do {
                let object: T = try parser.parsData(data: data)
                reponse = .success(object)
            } catch {
                response = .error(error)
            }

            onCompletion(response)
        })

        task.resume()
    }
}
