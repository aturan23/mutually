//
//  PasswordKeyboardView.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

final class PasswordKeyboardView: UIView {
    enum Constants {
        static let buttonsTypes: [PasswordKeyboardButtonType] = [
            .digit("1"),   .digit("2"),    .digit("3"),
            .digit("4"),   .digit("5"),    .digit("6"),
            .digit("7"),   .digit("8"),    .digit("9"),
            .biometry,     .digit("0"),    .backspace
        ]
        static let buttonsVerticalSpacing: CGFloat = 4
        static let buttonsHorizontalSpacing: CGFloat = 5
        static let countInRow: Int = 3
    }
    
    // MARK: - Public properties
    
    weak var output: PasswordKeyboardViewOutput?
    
    // MARK: - Private properties
    
    private let biometryIcon: UIImage?
    
    // MARK: - UI components
    
    private lazy var buttons: [Button] = Constants.buttonsTypes
        .enumerated()
        .compactMap ({ (index, buttonType) in
            return makeButton(for: buttonType, with: index)
        })
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.buttonsVerticalSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Init
    
    required init(withBiometryIcon biometryIcon: UIImage? = nil) {
        self.biometryIcon = biometryIcon
        super.init(frame: .zero)
        setupViewHierarchy()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupViewHierarchy() {
        addSubview(verticalStackView)
        for index in stride(from: 0, to: buttons.count, by: Constants.countInRow) {
            let rightOfHorizont = min(buttons.count, index + Constants.countInRow)
            let buttonsForRow = Array(buttons[index ..< rightOfHorizont])
            let horizontalView = makeHorizontalContainerView(for: buttonsForRow)
            verticalStackView.addArrangedSubview(horizontalView)
        }
    }
    
    private func layoutViews() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor
                .constraint(equalTo: topAnchor, constant: LayoutGuidance.offset),
            verticalStackView.leftAnchor
                .constraint(equalTo: leftAnchor, constant: LayoutGuidance.offset),
            verticalStackView.rightAnchor
                .constraint(equalTo: rightAnchor, constant: -LayoutGuidance.offset),
            verticalStackView.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -LayoutGuidance.offset)
        ])
    }
    
    private func makeButton(for buttonType: PasswordKeyboardButtonType,
                            with index: Int) -> Button? {
        var button: Button?
        switch buttonType {
        case .digit(let value):
            button = Button.makeForPassword(with: String(value))
        case .biometry:
            if let icon = self.biometryIcon {
                button = Button.makeForPassword(icon: icon)
            }
        case .backspace:
            button = Button.makeForPassword(icon: Asset.passwordKeyboardBackspace.image)
        }
        button?.touchUpInside = { [weak self] in
            self?.output?.didPressButton(type: Constants.buttonsTypes[index])
        }
        return button
    }
    
    private func makeHorizontalContainerView(for buttons: [Button]) -> UIView {
        let stackView: UIStackView
        if buttons.count == Constants.countInRow - 1 {
            stackView = UIStackView(arrangedSubviews: [UIView()] + buttons)
        } else {
            stackView = UIStackView(arrangedSubviews: buttons)
        }
        stackView.axis = .horizontal
        stackView.spacing = Constants.buttonsHorizontalSpacing
        stackView.distribution = .fillEqually
        return stackView
    }
}
