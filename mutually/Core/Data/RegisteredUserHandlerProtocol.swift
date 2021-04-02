//
//  RegisteredUserHandlerProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol RegisteredUserHandlerProtocol: class {
    var currentUser: RegisteredUserData? { get }
    func set(userData: RegisteredUserData?)
    func changeAutoLogin(should: Bool)
}
