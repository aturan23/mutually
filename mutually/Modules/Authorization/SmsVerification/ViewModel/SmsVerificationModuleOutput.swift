//
//  SmsVerificationModuleOutput.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol SmsVerificationModuleOutput: class {
    func smsVerificationSucceeded(with data: Codable?)
    func smsVerificationDidCancel()
}

extension SmsVerificationModuleOutput {
    func smsVerificationDidCancel() { }
}
