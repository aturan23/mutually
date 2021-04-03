//
//  SmsVerificationViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class SmsVerificationViewModel: SmsVerificationViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SmsVerificationViewInput?
    var router: SmsVerificationRouterInput?
    weak var moduleOutput: SmsVerificationModuleOutput?
    var smsService: SmsServiceProtocol?
    
    private var configData: SmsVerificationConfigData?

    // ------------------------------
    // MARK: - SmsVerificationViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SmsVerificationViewAdapter())
    }
}

// ------------------------------
// MARK: - SmsVerificationModuleInput methods
// ------------------------------

extension SmsVerificationViewModel: SmsVerificationModuleInput {
    func configure(data: SmsVerificationConfigData) {
        configData = data
    }
}
