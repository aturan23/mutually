//
//  KeyboardListening.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

@objc protocol KeyboardListening {
    @objc func keyboardWillShow(notification: NSNotification)
    @objc func keyboardWillHide(notification: NSNotification)
}
