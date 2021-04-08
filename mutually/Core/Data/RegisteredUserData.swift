//
//  RegisteredUserData.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//


struct RegisteredUserData: Codable {
    var phone: String
    var token: String?
    var shouldAutoLogin: Bool = false
}
