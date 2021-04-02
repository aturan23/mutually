//
//  RegisteredUserHandler.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

final class RegisteredUserHandler: RegisteredUserHandlerProtocol {
    private static let key = "RegisteredUserData"

    private let storage: UserDefaults
    
    init(storage: UserDefaults) {
        self.storage = storage
    }
    
    var currentUser: RegisteredUserData? {
        let decoder = JSONDecoder()
        if let savedData = storage.object(forKey: RegisteredUserHandler.key) as? Data,
            let userData = try? decoder.decode(RegisteredUserData.self, from: savedData) {
            return userData
        }
        return nil
    }
    
    func set(userData: RegisteredUserData?) {
        guard let userData = userData else {
            storage.set(nil, forKey: RegisteredUserHandler.key)
            return
        }
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(userData) {
            storage.set(encodedData, forKey: RegisteredUserHandler.key)
        }
    }
    
    func changeAutoLogin(should: Bool) {
        guard var currentUser = currentUser else {
            return
        }
        currentUser.shouldAutoLogin = should
        set(userData: currentUser)
    }
}
