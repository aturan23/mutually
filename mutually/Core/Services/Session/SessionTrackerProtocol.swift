//
//  SessionTrackerProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol SessionTrackerProtocol: class {
    var shouldSuggestAlternativeLoginMethods: Bool { get set }
    var isLoggedIn: Bool { get }
    func didLogin()
    func logOut(sessionTimeout: Bool)
}
