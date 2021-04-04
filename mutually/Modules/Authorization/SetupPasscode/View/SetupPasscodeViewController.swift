//
//  SetupPasscodeViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit
import SnapKit

class SetupPasscodeViewController: BaseViewController, SetupPasscodeViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: SetupPasscodeViewOutput?
    private var createViewCenterXConstraint: Constraint?
    private var repeatViewCenterXConstraint: Constraint?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let labelFactory = LabelFactory()
    private lazy var passwordViewInput: SmsInputViewInput = passwordView
    
    private let createContainerView = UIView()
    private lazy var createPasswordLabel = labelFactory.make(
        withStyle: .paragraphSecondary,
        text: "Придумайте 4х-значный пароль для последующего входа в приложение",
        textColor: Color.textHighContrast)
    private lazy var passwordView: SmsInputView = {
        let view = SmsInputView(codeLength: 4, isEnabled: false)
        view.output = self
        return view
    }()
    
    private let repeatContainerView = UIView()
    private lazy var repeatPasswordLabel = labelFactory.make(
        withStyle: .paragraphSecondary,
        text: "Повторите введенный ранее 4х-значный пароль для его подтверждения",
        textColor: Color.textHighContrast)
    private lazy var repeatPasswordView: SmsInputView = {
        let view = SmsInputView(codeLength: 4, isEnabled: false)
        view.output = self
        return view
    }()
    
    private lazy var keyboardView: PasswordKeyboardView = {
        let view = PasswordKeyboardView()
        view.output = self
        return view
    }()

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // ------------------------------
    // MARK: - SetupPasscodeViewInput
    // ------------------------------

    func showCreate() {
        passwordViewInput = passwordView as SmsInputViewInput
        animateInputContainers(showLeft: true)
    }
    
    func showRepeat() {
        passwordViewInput = repeatPasswordView as SmsInputViewInput
        animateInputContainers(showLeft: false)
    }
    
    func showError(adapter: SetupPasscodeViewAdapter) {
        switch adapter.errorType {
        case .tooSimplePasscode:
            passwordView.showError(message: "Придумай пароль посложнее")
        case .passcodeMismatch:
            passwordView.showError()
            repeatPasswordView.showError(message: "Пароли не совпадают", onHideAction: showCreate)
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


        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [createPasswordLabel, passwordView].forEach(createContainerView.addSubview(_:))
        [repeatPasswordLabel, repeatPasswordView].forEach(repeatContainerView.addSubview(_:))
        [createContainerView, repeatContainerView, keyboardView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        createContainerView.snp.makeConstraints {
            $0.top.equalTo(LayoutGuidance.offsetSuperLarge)
            createViewCenterXConstraint = $0.centerX.equalToSuperview().constraint
            $0.width.equalToSuperview()
        }
        
        [createPasswordLabel, repeatPasswordLabel].forEach {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
            }
        }
        passwordView.snp.makeConstraints {
            $0.top.equalTo(createPasswordLabel.snp.bottom).offset(LayoutGuidance.offsetSuperLarge * 3)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        repeatContainerView.snp.makeConstraints {
            $0.top.equalTo(LayoutGuidance.offsetSuperLarge)
            repeatViewCenterXConstraint = $0.centerX.equalToSuperview().offset(view.bounds.width).constraint
            $0.width.equalToSuperview()
        }
        repeatPasswordView.snp.makeConstraints {
            $0.top.equalTo(repeatPasswordLabel.snp.bottom).offset(LayoutGuidance.offsetSuperLarge * 3)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        var viewSafeAreaHeight: CGFloat = view.bounds.height
        if let windowInsets = UIApplication.shared.keyWindow?.safeAreaInsets {
            viewSafeAreaHeight -= windowInsets.top + windowInsets.bottom
        }
        keyboardView.snp.makeConstraints {
            $0.height.equalTo(viewSafeAreaHeight / 2)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
    
    private func animateInputContainers(showLeft: Bool) {
        let offset = view.bounds.width
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.createViewCenterXConstraint?.update(offset: showLeft ? 0 : -offset)
                self?.repeatViewCenterXConstraint?.update(offset: showLeft ? offset : 0)
                self?.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
}

// ------------------------------
// MARK: - SmsInputViewOutput
// ------------------------------

extension SetupPasscodeViewController: SmsInputViewOutput {
    
    func didComplete(inputView: SmsInputView, code: String) {
        if inputView == passwordView {
            output?.didCreate(passcode: code)
        } else if inputView == repeatPasswordView {
            output?.didTryToRepeat(passcode: code)
        }
    }
}

// ------------------------------
// MARK: - PasswordKeyboardViewOutput
// ------------------------------

extension SetupPasscodeViewController: PasswordKeyboardViewOutput {
    
    func didPressButton(type: PasswordKeyboardButtonType) {
        switch type {
        case .digit(let value):
            passwordViewInput.append(symbol: value)
        case .backspace:
            passwordViewInput.eraseLastSymbol()
        case .biometry: break
        }
    }
}
