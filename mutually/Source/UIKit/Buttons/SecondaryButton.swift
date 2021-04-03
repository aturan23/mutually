//
//  SecondaryButton.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

extension Button {
    static func makeSecondary(with text: String? = nil,
                              textColor: UIColor = Color.buttonPrimaryFillRegular,
                              textStyle: TextStyle = .buttonSecondary,
                              icon: UIImage? = nil) -> Button {
        let button = Button(icon: icon,
                            text: text,
                            textStyle: textStyle,
                            textColor: textColor,
                            withShadow: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }
}
