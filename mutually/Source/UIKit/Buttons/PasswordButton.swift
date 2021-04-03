//
//  PasswordButton.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

extension Button {
    static func makeForPassword(with text: String? = nil,
                                icon: UIImage? = nil) -> Button {
        return Button(icon: icon,
                      pressedIconColor: UIColor.white,
                      text: text,
                      textStyle: .passwordKeyboard,
                      textColor: .black,
                      pressedTextColor: .white,
                      backgroundColor: .clear,
                      pressedColor: Color.buttonPrimaryFillRegular,
                      cornerRadius: 16,
                      withShadow: false)
    }
}
