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
    private let dataProcessingCashbackView = CheckBoxView()
    private let termsCheckboxView = CheckBoxView()
    private let button = Button.makePrimary(with: "Подтвердить телефон")
    

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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        phoneFieldView.resignFirstResponder()
    }

    // ------------------------------
    // MARK: - RegistrationViewInput
    // ------------------------------

    func display(viewAdapter: RegistrationViewAdapter) { }
    
    // ------------------------------
    // MARK: - KeyboardListening
    // ------------------------------
    
    func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardFrame: NSValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        moveButton(bottomInset: LayoutGuidance.offsetHalf + keyboardHeight)
    }
    
    func keyboardWillHide(notification: NSNotification) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        titleLabel.numberOfLines = 0
        
        dataProcessingCashbackView.title = "Соглашение на обработку персональных данных"
        termsCheckboxView.title = "Публичная оферта, условия использования сервиса"

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [imageView,
         titleLabel,
         phoneFieldView,
         dataProcessingCashbackView,
         termsCheckboxView,
         button].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(Constants.imageSize)
            $0.left.equalTo(LayoutGuidance.offsetSuperLarge)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-LayoutGuidance.offsetSuperLarge)
        }
        [titleLabel, phoneFieldView, dataProcessingCashbackView, termsCheckboxView, button].forEach {
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
            $0.bottom.equalTo(termsCheckboxView.snp.top).offset(-LayoutGuidance.offset)
        }
        termsCheckboxView.snp.makeConstraints {
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
