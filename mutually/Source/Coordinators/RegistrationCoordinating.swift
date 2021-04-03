//
//  RegistrationCoordinating.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol Coordinator {
    func start()
}

protocol RegistrationCoordinating: Coordinator {
    func moveToSignIn(data: SignInConfigData, animating: Bool)
    func showMainPage()
}
