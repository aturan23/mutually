//
//  SmsVerificationViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class SmsVerificationViewController: BaseViewController, SmsVerificationViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: SmsVerificationViewOutput?
    private var state: SmsVerificationViewState?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private let labelFactory = LabelFactory()
    private lazy var titleLabel = labelFactory.make(
        withStyle: .inputLabel,
        text: "Мы отправили смс на указанный ранее вами номер, введите полученный код ниже",
        textColor: .black)
    private lazy var timerLabel = labelFactory.make(
        withStyle: .paragraphCaptionCaps,
        textColor: Color.textLowContrast,
        textAlignment: .center)
    private lazy var resendSmsButton: Button = {
        let button = Button.makeSecondary(with: "Запросить СМС повторно")
        button.touchUpInside = { [weak self] in
            self?.output?.didTapResendCode()
        }
        return button
    }()
    private lazy var codeInputView: SmsInputView = {
        let view = SmsInputView()
        view.output = self
        
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(didTapCodeInput))
        view.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(
            target: self, action: #selector(didLongPressCodeInput))
        view.addGestureRecognizer(longPressGesture)
        
        return view
    }()
    private lazy var descLabel = labelFactory.make(
        withStyle: .paragraphCaption,
        text: "Вводя код из СМС, Вы соглашаетесь с условиями и подписываете согласия своим аналогом простой электронной цифровой подписи",
        textColor: Color.textLowContrast,
        textAlignment: .center)
    
    private lazy var requestingIndicator = UIActivityIndicatorView.makeDefault()
    
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }
    
    // MARK: - Menu control
    
    override func paste(_ sender: Any?) {
        if let copiedText = UIPasteboard.general.string {
            codeInputView.set(otp: copiedText)
        }
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(paste(_:))
    }

    // ------------------------------
    // MARK: - SmsVerificationViewInput
    // ------------------------------

    func display(viewAdapter: SmsVerificationViewAdapter) { }
    
    func apply(state: SmsVerificationViewState) {
        self.state = state
        switch state {
        case .requestingCode:
            timerLabel.isHidden = true
            resendSmsButton.isHidden = true
            requestingIndicator.isHidden = false
            codeInputView.resignFirstResponder()
        case .inputCode:
            timerLabel.isHidden = false
            resendSmsButton.isHidden = true
            requestingIndicator.isHidden = true
            codeInputView.resetOtp()
            codeInputView.becomeFirstResponder()
        case .requestNewCode:
            timerLabel.isHidden = true
            resendSmsButton.isHidden = false
            requestingIndicator.isHidden = true
            codeInputView.resetOtp()
        case .validatingCode:
            timerLabel.isHidden = false
            resendSmsButton.isHidden = true
            requestingIndicator.isHidden = true
            codeInputView.disableInput()
            codeInputView.resignFirstResponder()
        }
        if timerLabel.isHidden {
            timerLabel.setAttributedText(to: nil)
        }
    }
    
    func getCurrentState() -> SmsVerificationViewState? {
        return state
    }
    
    func updateTimerInfo(text: String) {
        timerLabel.setAttributedText(to: text)
    }
    
    func show(errorData: SmsVerificationErrorViewAdapter) {
        switch errorData.data {
        case .incorrectCode:
            codeInputView.showError(message: "Вы ввели не верный СМС код")
        case .couldNotRequestSms, .other:
            codeInputView.showError(message: nil)
        case .networkFail: break
        }
    }
    
    func startLoading() {
        showLoading()
    }

    func stopLoading() {
        hideLoading()
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        requestingIndicator.isHidden = true

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [titleLabel,
         timerLabel,
         codeInputView,
         descLabel,
         resendSmsButton,
         requestingIndicator].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top).offset(LayoutGuidance.offsetSuperLarge)
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
        }
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(LayoutGuidance.offsetSuperLarge)
            $0.centerX.equalToSuperview()
        }
        requestingIndicator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(LayoutGuidance.offsetSuperLarge)
            $0.centerX.equalToSuperview()
        }
        codeInputView.snp.makeConstraints {
            $0.top.equalTo(timerLabel).offset(LayoutGuidance.offsetSuperLarge)
            $0.centerX.equalToSuperview()
        }
        descLabel.snp.makeConstraints {
            $0.top.equalTo(codeInputView.snp.bottom).offset(LayoutGuidance.offsetSuperLarge)
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
        }
        resendSmsButton.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(LayoutGuidance.offset)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func didTapCodeInput() {
        if !codeInputView.isFirstResponder {
            codeInputView.becomeFirstResponder()
        }
    }
    
    @objc private func didLongPressCodeInput() {
        codeInputView.becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(codeInputView.bounds, in: codeInputView)
            menu.setMenuVisible(true, animated: true)
        }
    }
}

// ------------------------------
// MARK: - SmsInputViewOutput methods
// ------------------------------

extension SmsVerificationViewController: SmsInputViewOutput {
    func didComplete(inputView: SmsInputView, code: String) {
        output?.didFillField(smsCode: code)
    }
}
