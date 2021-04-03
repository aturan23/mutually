//
//  RegistrationRouter.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class RegistrationRouter: RegistrationRouterInput {
	weak var viewController: UIViewController?
    private let smsModuleAssembly: SmsVerificationModuleAssembly?
    
    init(smsModuleAssembly: SmsVerificationModuleAssembly?) {
        self.smsModuleAssembly = smsModuleAssembly
    }
    
	// ------------------------------
    // MARK: - RegistrationRouterInput
    // ------------------------------
    
    func showSmsVerification(phone: String, moduleOutput: SmsVerificationModuleOutput) {
        guard
            let smsViewController = smsModuleAssembly?.assemble(
                for: .registration,
                configuration:  { moduleInput in
                    moduleInput.configure(data: SmsVerificationConfigData(phone: phone))
                    return moduleOutput
            })
            else {
                return
        }
        viewController?.navigationController?.pushViewController(smsViewController, animated: true)
    }
}
