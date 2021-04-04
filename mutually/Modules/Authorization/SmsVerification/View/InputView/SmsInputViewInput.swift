//
//  SmsInputViewInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

protocol SmsInputViewInput: class {
    func append(symbol: Character)
    func eraseLastSymbol()
    func disableInput()
    func showError(message: String?)
    func set(otp: String)
    func resetOtp()
}

protocol SmsInputViewOutput: class {
    func didComplete(inputView: SmsInputView, code: String)
}
