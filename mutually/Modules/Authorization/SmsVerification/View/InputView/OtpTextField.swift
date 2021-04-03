//
//  OtpTextField.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

final class OtpTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        keyboardType = .numberPad
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
    }
}
