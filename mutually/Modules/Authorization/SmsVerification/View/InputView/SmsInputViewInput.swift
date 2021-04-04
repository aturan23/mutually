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
    func showError(message: String?, onHideAction: (() -> Void)?)
    func set(otp: String)
    func resetOtp()
}

extension SmsInputViewInput {
    func showError(message: String? = nil, onHideAction: (() -> Void)? = nil) {
        showError(message: message, onHideAction: onHideAction)
    }
}

protocol SmsInputViewOutput: class {
    func didComplete(inputView: SmsInputView, code: String)
}
