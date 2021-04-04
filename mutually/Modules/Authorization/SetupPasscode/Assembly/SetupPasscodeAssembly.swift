//
//  SetupPasscodeAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias SetupPasscodeConfiguration = (SetupPasscodeModuleInput) -> SetupPasscodeModuleOutput?

class SetupPasscodeModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: SetupPasscodeConfiguration? = nil) -> UIViewController {
        let viewController = SetupPasscodeViewController()
        let router = SetupPasscodeRouter()
        let viewModel = SetupPasscodeViewModel()
        viewModel.view = viewController
        viewModel.router = router
        viewModel.authorizationService = injection.inject(AuthorizationServiceProtocol.self)
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
