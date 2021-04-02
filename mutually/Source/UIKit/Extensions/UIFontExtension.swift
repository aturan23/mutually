//
//  UIFontExtension.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

extension UIFont {
    static func regular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Ekibastuz-Regular", size: size) else {
            return .systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
    
    static func semibold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Ekibastuz-Semibold", size: size) else {
            return .systemFont(ofSize: size, weight: .semibold)
        }
        return font
    }
    
    static func bold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Ekibastuz-Bold", size: size) else {
            return .systemFont(ofSize: size, weight: .bold)
        }
        return font
    }
}
