//
//  RegistrationViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol RegistrationViewInput: class {
    func display(viewAdapter: RegistrationViewAdapter)
    func getPhoneFieldText() -> String
    func phoneError()
}

protocol RegistrationViewOutput {
    func didLoad()
    func didTapButton()
}
