//
//  SmsInputViewInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

protocol SmsInputViewInput: class {
    func disableInput()
    func showError()
    func set(otp: String)
    func resetOtp()
}

protocol SmsInputViewOutput: class {
    func didComplete(smsCode: String)
}
