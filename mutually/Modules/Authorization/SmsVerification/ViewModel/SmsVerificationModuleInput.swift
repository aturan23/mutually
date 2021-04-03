//
//  SmsVerificationModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for SmsVerification initial configuration 
/// through SmsVerificationModuleInput
struct SmsVerificationConfigData {
    var phone: String
}

/// Protocol with public methods to configure SmsVerification 
/// from its parent module (usually implemented by this module's ViewModel)
protocol SmsVerificationModuleInput: class {
    var smsService: SmsServiceProtocol? { get set }
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: SmsVerificationConfigData)
}
