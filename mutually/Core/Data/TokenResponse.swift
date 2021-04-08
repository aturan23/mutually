//
//  TokenResponse.swift
//  mutually
//
//  Created by Turan Assylkhan on 06.04.2021.
//

import Foundation

struct TokenResponse: Codable {
    
    struct Token: Codable {
        let hash: String
    }
    
    let data: Token
}
