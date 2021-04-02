//
//  SignInAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias SignInConfiguration = (SignInModuleInput) -> SignInModuleOutput?

class SignInModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: SignInConfiguration? = nil) -> UIViewController {
        let viewController = SignInViewController()
        let router = SignInRouter()
        let viewModel = SignInViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
