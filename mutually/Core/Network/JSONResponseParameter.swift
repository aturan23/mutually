//
//  JSONResponseParameter.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

enum JSONResponseParameter: String {
    case token
    case success
    
    var key: String {
        return rawValue
    }
}
