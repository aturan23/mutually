//
//  SmsVerificationViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol SmsVerificationViewInput: class {
    func display(viewAdapter: SmsVerificationViewAdapter)
    func apply(state: SmsVerificationViewState)
    func getCurrentState() -> SmsVerificationViewState?
    func updateTimerInfo(text: String)
    func show(errorData: SmsVerificationErrorViewAdapter)
    func startLoading()
    func stopLoading()
}

protocol SmsVerificationViewOutput {
    func didLoad()
    func didTapResendCode()
    func didFillField(smsCode: String)
}
