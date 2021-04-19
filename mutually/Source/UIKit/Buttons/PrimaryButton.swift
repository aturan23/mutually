//
//  PrimaryButton.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

extension Button {
    static func makePrimary(with text: String? = nil) -> Button {
        let button = Button(text: text,
                            textStyle: .buttonPrimary,
                            textColor: .white,
                            backgroundColor: Color.buttonPrimaryFillRegular,
                            pressedColor: Color.buttonPrimaryFillActive,
                            disabledColor: Color.buttonPrimaryFillRegular,
                            cornerRadius: 8,
                            withShadow: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: LayoutGuidance.buttonHeight).isActive = true
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .white
        indicatorView.color = .white
        button.indicator = indicatorView
        return button
    }
}
