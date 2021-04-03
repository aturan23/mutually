//
//  SmsVerificationViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol SmsVerificationViewInput: class {
    func display(viewAdapter: SmsVerificationViewAdapter)
}

protocol SmsVerificationViewOutput {
    func didLoad()
}
