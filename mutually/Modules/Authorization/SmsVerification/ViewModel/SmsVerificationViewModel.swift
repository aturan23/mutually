//
//  SmsVerificationViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import Foundation

class SmsVerificationViewModel: SmsVerificationViewOutput {
    
    enum Constants {
        static let timerDuration: Int = 60
        static let confirmationsCountLimit: Int = 3
    }

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SmsVerificationViewInput?
    var router: SmsVerificationRouterInput?
    weak var moduleOutput: SmsVerificationModuleOutput?
    var smsService: SmsServiceProtocol?
    
    private var configData: SmsVerificationConfigData?
    private var stateBeforeValidating: SmsVerificationViewState?
    
    // Timer properties
    private var countdownTimer: Timer!
    private var timerCounter = 0
    private var confirmationsCounter = 0

    // ------------------------------
    // MARK: - SmsVerificationViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SmsVerificationViewAdapter())
        requestSmsCode()
    }
    
    func didTapResendCode() {
        requestSmsCode()
    }
    
    func didFillField(smsCode: String) {
        confirmSmsCode(smsCode)
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func requestSmsCode() {
        view?.apply(state: .requestingCode)
        smsService?.requestSMSCode(completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.confirmationsCounter = 0
                self.startTimer()
            case .failure(let error):
                self.router?.showAlert(
                    title: "Не удалось отправить код подтверждения",
                    message: error.message,
                    completion: { [weak self] in
                        self?.view?.apply(state: .requestNewCode)
                    })
            }
        })
    }
    
    private func confirmSmsCode(_ code: String) {
        guard confirmationsCounter < Constants.confirmationsCountLimit else {
            showCodeExpiredAlert()
            return
        }
        confirmationsCounter += 1
        stateBeforeValidating = view?.getCurrentState()
        view?.apply(state: .validatingCode)
        view?.startLoading()
        smsService?.confirmSMSCode(code: code, completion: { [weak self] (result) in
            guard let self = self else { return }
            self.view?.stopLoading()
            switch result {
            case .success(let json):
                self.router?.routeBack(completion: { [weak self] in
                    self?.moduleOutput?.smsVerificationSucceeded(with: json)
                })
            case .failure(let error):
                var errorAdapter: SmsVerificationErrorViewAdapter = .init(data: .incorrectCode)
                var state: SmsVerificationViewState = .inputCode
                if case .networkFail = error {
                    errorAdapter = .init(data: .networkFail)
                    state = .requestNewCode
                }
                self.view?.apply(state: state)
                self.view?.show(errorData: errorAdapter)
            }
        })
    }
    
    private func startTimer() {
        timerCounter = Constants.timerDuration
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        view?.apply(state: .inputCode)
    }
    
    private func stopTimer() {
        countdownTimer.invalidate()
        view?.apply(state: .requestNewCode)
    }
    
    @objc private func updateTimer() {
        timerCounter -= 1
        if timerCounter < 0 {
            if view?.getCurrentState() != .validatingCode {
                stopTimer()
            }
        } else {
            let text = "00:\(timerCounter)"
            view?.updateTimerInfo(text: text)
        }
    }
    
    private func showCodeExpiredAlert() {
        router?.showAlert(
            title: "Получи новый код",
            message: "Предыдущий код устарел",
            completion: { [weak self] in
                self?.view?.apply(state: .inputCode)
        })
    }
}

// ------------------------------
// MARK: - SmsVerificationModuleInput methods
// ------------------------------

extension SmsVerificationViewModel: SmsVerificationModuleInput {
    func configure(data: SmsVerificationConfigData) {
        configData = data
    }
}
