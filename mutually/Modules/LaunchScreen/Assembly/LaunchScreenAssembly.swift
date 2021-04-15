//
//  LaunchScreenAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 14/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class LaunchScreenModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ moduleOutput: LaunchScreenModuleOutput) -> UIViewController {
        let viewModel = LaunchScreenViewModel(moduleOutput: moduleOutput)
        viewModel.authService = injection.inject(AuthorizationServiceProtocol.self)
        let viewController = LaunchScreenViewController()
        viewController.output = viewModel
        return viewController
    }
}
