//
//  ErrorResponse.swift
//  GymDone
//
//  Created by Artak on 1/22/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

struct ResponseDataContainer<Data: Codable>: Codable {
    let error: Bool?
    let message: String?
    let data: Data?
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try? values.decode(Bool.self, forKey: .error)
        message = try? values.decode(String.self, forKey: .message)
        data = try values.decode(Data.self, forKey: .data)
    }
}
