//
//  NetworkResponse.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

struct NetworkResponse: Codable {
    let result: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultSring = try container.decodeIfPresent(String.self, forKey: .result)
        result = resultSring == JSONResponseParameter.success.key
    }
}
