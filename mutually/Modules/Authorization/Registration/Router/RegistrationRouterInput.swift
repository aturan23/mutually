//
//  RegistrationRouterInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol RegistrationRouterInput {
    func showSmsVerification(phone: String,
                             moduleOutput: SmsVerificationModuleOutput)
}
