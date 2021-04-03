//
//  SmsVerificationAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias SmsVerificationConfiguration = (SmsVerificationModuleInput) -> SmsVerificationModuleOutput?

class SmsVerificationModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(
        for purpose: SmsVerificationPurpose,
        configuration: SmsVerificationConfiguration? = nil) -> UIViewController {
        let viewController = SmsVerificationViewController()
        let router = SmsVerificationRouter()
        let viewModel = SmsVerificationViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        switch purpose {
        case .registration:
            viewModel.smsService = injection.inject(AuthorizationServiceProtocol.self)
        }
        return viewController
    }
}
