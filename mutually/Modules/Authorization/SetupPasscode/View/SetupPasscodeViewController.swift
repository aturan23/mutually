//
//  SetupPasscodeViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class SetupPasscodeViewController: BaseViewController, SetupPasscodeViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: SetupPasscodeViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let labelFactory = LabelFactory()
    
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
        [keyboardView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
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
// MARK: - PasswordKeyboardViewOutput
// ------------------------------

extension SetupPasscodeViewController: PasswordKeyboardViewOutput {
    func didPressButton(type: PasswordKeyboardButtonType) {
//        switch type {
//        case .digit(let value):
//            passwordViewInput.append(symbol: value)
//        case .backspace:
//            passwordViewInput.eraseLastSymbol()
//        case .biometry:
//            break
//        }
    }
}
