//
//  Parser.swift
//  YooSpend
//
//  Created by Artak on 12/24/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

class Parser {
    func parsData<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()

        return try decoder.decode(T.self, from: data)
    }
    
    func parsData<T: Decodable>(data: Data) throws -> [T] {
        let decoder = JSONDecoder()
        
        return try decoder.decode([T].self, from: data)
    }
}
