//
//  SmsVerificationViewAdapter.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Default ViewModel passed to View layer for displaying
struct SmsVerificationViewAdapter { }

struct SmsVerificationErrorViewAdapter {
    enum ErrorType {
        case incorrectCode
        case couldNotRequestSms
        case other(message: String)
        case networkFail
    }
    var data: ErrorType = .incorrectCode
    init(data: ErrorType) {
        self.data = data
    }
}
