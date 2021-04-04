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
        let view = SmsInputView(codeLength: 4)
        view.output = self
        return view
    }()
    
    private lazy var repeatPasswordLabel = labelFactory.make(
        withStyle: .paragraphSecondary,
        text: "Повторите введенный ранее 4х-значный пароль для его подтверждения",
        textColor: Color.textHighContrast)
    
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
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - SetupPasscodeViewInput
    // ------------------------------

    func display(viewAdapter: SetupPasscodeViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {


        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [createPasswordLabel, passwordView].forEach(createContainerView.addSubview(_:))
        [createContainerView, keyboardView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        createPasswordLabel.snp.makeConstraints {
            $0.top.width.equalToSuperview()
        }
        passwordView.snp.makeConstraints {
            $0.top.equalTo(createPasswordLabel.snp.bottom).offset(LayoutGuidance.offsetSuperLarge)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        createContainerView.snp.makeConstraints {
            createViewCenterXConstraint = $0.centerX.equalToSuperview().constraint
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
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
}

// ------------------------------
// MARK: - SmsInputViewOutput
// ------------------------------

extension SetupPasscodeViewController: SmsInputViewOutput {
    
    func didComplete(inputView: SmsInputView, code: String) {
        if inputView == passwordView {
//            output?.didCreate(passcode: password)
        }// else if inputView == repeatPasswordView {
//            output?.didTryToRepeat(passcode: password)
//        }
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
