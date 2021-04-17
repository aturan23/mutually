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
    case token
    case summ
    case term
    case type
    case userFile
    
    var key: String {
        return rawValue
    }
}
