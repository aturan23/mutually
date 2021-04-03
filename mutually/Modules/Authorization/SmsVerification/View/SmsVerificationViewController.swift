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

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private let labelFactory = LabelFactory()
    private lazy var titleLabel = labelFactory.make(
        withStyle: .inputLabel,
        text: "Мы отправили смс на указанный ранее вами номер, введите полученный код ниже",
        textColor: .black)
    
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - SmsVerificationViewInput
    // ------------------------------

    func display(viewAdapter: SmsVerificationViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [titleLabel].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top).offset(LayoutGuidance.offsetSuperLarge)
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
        }
    }
}
