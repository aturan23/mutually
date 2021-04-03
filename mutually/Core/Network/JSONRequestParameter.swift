//
//  JSONRequestParameter.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

enum JSONRequestParameter: String {
    case action
    case login
    case password
    
    var key: String {
        return rawValue
    }
}
