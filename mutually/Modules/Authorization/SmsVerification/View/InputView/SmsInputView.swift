//
//  SmsInputView.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

final class SmsInputView: UIView {
    enum Constant {
        static let defaultCodeLength = 4
        static let textFieldFont = UIFont.regular(size: 17)

        static let placeholderText: String = "0"
        static let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.textLowContrast
        ]
        static let activePlaceholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.textLowContrast
        ]
        static let labelTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: textFieldFont
        ]
        static let errorLabelTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.error,
            .font: textFieldFont
        ]

        static let textFieldSpacing: CGFloat = LayoutGuidance.offset
        static let stackViewHorizontalOffset: CGFloat = 51
        static let stackViewVerticalOffset: CGFloat = 13
        static let defaultBackgroundColor: UIColor = Color.textLowContrast
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - UI components
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 28
        return stackView
    }()
    
    private lazy var otpTextField: OtpTextField = {
        let field = OtpTextField()
        field.alpha = 0
        field.addTarget(self,
                        action: #selector(handleOtpValueChange),
                        for: .editingChanged)
        return field
    }()
    
    // MARK: - Properties
    
    private let codeLength: Int
    private var isShowingError: Bool = false
    weak var output: SmsInputViewOutput?
    
    // MARK: - Init
    
    required init(codeLength: Int = Constant.defaultCodeLength) {
        self.codeLength = codeLength
        super.init(frame: .zero)
        configureViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Responder handle
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return otpTextField.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        return otpTextField.resignFirstResponder()
    }
    
    // MARK: - Private methods
    
    private func configureViews() {
        arrangeInputLabels()
        
        [stackView, otpTextField].forEach(addSubview(_:))
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(Constant.stackViewVerticalOffset)
        }
        otpTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func arrangeInputLabels() {
        stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview)
        for i in 0..<codeLength {
            let attr = i == 0 ? Constant.activePlaceholderAttributes : Constant.placeholderAttributes
            let label = UILabel()
            label.tag = i
            label.attributedText = NSAttributedString(string: Constant.placeholderText,
                                                      attributes: attr)
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 20).isActive = true
        }
    }
    
    private func displayOtpValue(text: String) {
        let labels = stackView.subviews.compactMap({ $0 as? UILabel })
        guard text.count <= labels.count else { return }
        let eligibleLabels = labels.filter({ label in
            return label.tag < text.count
        })
        let nonEligibleLabels = labels.filter({ label in
            return label.tag >= text.count
        })
        for (value, label) in zip(Array(text), eligibleLabels) {
            label.attributedText = NSAttributedString(string: String(value),
                                                      attributes: Constant.labelTextAttributes)
            label.font = Constant.textFieldFont
        }
        for (i, label) in nonEligibleLabels.enumerated() {
            let attr = i == 0 ? Constant.activePlaceholderAttributes : Constant.placeholderAttributes
            label.attributedText = NSAttributedString(string: Constant.placeholderText,
                                                      attributes: attr)
        }
    }
    
    private func resetAndActivateInput() {
        resetOtp()
        isShowingError = false
        otpTextField.isUserInteractionEnabled = true
        otpTextField.becomeFirstResponder()
    }
    
    @objc private func handleOtpValueChange() {
        guard let text = otpTextField.text else {
            return
        }
        let newText = String(text.prefix(self.codeLength))
        if self.otpTextField.text == newText {
            self.isShowingError = false
            if newText.count == self.codeLength {
                self.output?.didComplete(smsCode: newText)
            }
        } else {
            self.otpTextField.text = newText
        }
        self.displayOtpValue(text: newText)
    }
}

// MARK: - SmsInputViewInput
extension SmsInputView: SmsInputViewInput {
    func disableInput() {
        otpTextField.endEditing(true)
        otpTextField.isUserInteractionEnabled = false
    }
    
    func showError() {
        shake()
        let labels = stackView.subviews.compactMap({ $0 as? UILabel })
        labels.forEach { label in
            let value = label.text ?? Constant.placeholderText
            label.attributedText = NSAttributedString(string: value,
                                                      attributes: Constant.errorLabelTextAttributes)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.resetAndActivateInput()
        }
        isShowingError = true
    }
    
    func set(otp: String) {
        guard otp.onlyDigits == otp else {
            return
        }
        otpTextField.text?.append(
            String(otp.prefix(codeLength - (otpTextField.text?.count ?? 0)))
        )
        handleOtpValueChange()
    }
    
    func resetOtp() {
        otpTextField.text = ""
        displayOtpValue(text: "")
    }
}
