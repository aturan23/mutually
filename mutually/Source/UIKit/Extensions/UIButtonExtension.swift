//
//  UIButtonExtension.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

extension UIButton {
    static var allControlStates: [UIControl.State] {
        return [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved]
    }
    
    /**
     Set string value of button's attributedTitle,
     keeping all attributes that was set before.
    
    - Parameter title: The new optional string value for attributedTitle.
    */
    func setAttributedTitleKeepingAttributes(to title: String?) {
        for state in UIButton.allControlStates {
            if let mutableAttributedTitle = attributedTitle(for: state)?.mutableCopy(),
                let mutableAttributedText = mutableAttributedTitle as? NSMutableAttributedString {
                let newTitle = title ?? ""
                mutableAttributedText.mutableString
                    .setString(newTitle.isEmpty ? LabelFactory.emptyText : newTitle)
                setAttributedTitle(mutableAttributedText, for: state)
            }
        }
    }
}
