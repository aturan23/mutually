//
//  RegistrationViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit
import SnapKit

class RegistrationViewController: BaseViewController, RegistrationViewInput, KeyboardListening {
    
    private enum Constants {
        static let imageSize = CGSize(width: 137, height: 48)
        static let continueButtonHiddenInset: CGFloat = -38
    }

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: RegistrationViewOutput?
    private var buttonBottomConstraint: Constraint?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let labelFactory = LabelFactory()
    private let imageView = UIImageView(image: Asset.logo.image)
    private lazy var titleLabel = labelFactory.make(
        withStyle: .paragraphBody,
        text: "Введите номер телефона, мы отправим вам СМС для подтверждения",
        textColor: .black)
    private let phoneFieldView = TextFieldViewFactory()
        .makeForPhone(title: "Номер телефона")
    private lazy var dataProcessingCashbackView: CheckBoxView = {
        let checkbox = CheckBoxView()
        checkbox.textTap = { [weak self] in
            self?.output?.didTapLink()
        }
        return checkbox
    }()
    private lazy var button: Button = {
        let button = Button.makePrimary(with: "Подтвердить телефон")
        button.touchUpInside = { [weak self] in
            var form = RegistrationForm()
            form.phone = self?.phoneFieldView.getText().onlyDigits
            form.dataProcessingSelected = self?.dataProcessingCashbackView.isChecked ?? false
            self?.output?.didTapButton(with: form)
        }
        return button
    }()
    

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneFieldView.becomeFirstResponder()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        phoneFieldView.resignFirstResponder()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // ------------------------------
    // MARK: - RegistrationViewInput
    // ------------------------------

    func display(viewAdapter: RegistrationViewAdapter) {
        dataProcessingCashbackView.attributedTitle = viewAdapter.dataProcessingAttributes
    }
    
    func showError(phone: Bool, dataProcessing: Bool) {
        if phone { phoneFieldView.shake() }
        if dataProcessing { dataProcessingCashbackView.shake() }
    }
    
    func startLoading() {
        button.showLoader(userInteraction: false)
    }
    
    func stopLoading() {
        button.hideLoader()
    }
    
    // ------------------------------
    // MARK: - KeyboardListening
    // ------------------------------
    
    func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardFrame: NSValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        moveButton(bottomInset: LayoutGuidance.offset + keyboardHeight)
    }
    
    func keyboardWillHide(notification: NSNotification) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        titleLabel.numberOfLines = 0

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [imageView,
         titleLabel,
         phoneFieldView,
         dataProcessingCashbackView,
         button].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(Constants.imageSize)
            $0.left.equalTo(LayoutGuidance.offsetSuperLarge)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-LayoutGuidance.offsetSuperLarge)
        }
        [titleLabel, phoneFieldView, dataProcessingCashbackView, button].forEach {
            $0.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
            }
        }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(phoneFieldView.snp.top).offset(-LayoutGuidance.offsetSuperLarge)
        }
        phoneFieldView.snp.makeConstraints {
            $0.bottom.equalTo(dataProcessingCashbackView.snp.top).offset(-LayoutGuidance.offsetSuperLarge)
        }
        dataProcessingCashbackView.snp.makeConstraints {
            $0.bottom.equalTo(button.snp.top).offset(-LayoutGuidance.offsetSuperLarge)
        }
        button.snp.makeConstraints {
            buttonBottomConstraint = $0.bottom.equalTo(Constants.continueButtonHiddenInset).constraint
        }
    }
    
    private func moveButton(bottomInset: CGFloat) {
        let animations = { [weak self] in
            self?.buttonBottomConstraint?.update(inset: bottomInset)
            self?.view.layoutIfNeeded()
        }
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9, animations: {
            animations()
        })
        animator.startAnimation()
    }
}
