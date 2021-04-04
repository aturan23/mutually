//
//  SlidingRequestAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 04/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias SlidingRequestConfiguration = (SlidingRequestModuleInput) -> SlidingRequestModuleOutput?

class SlidingRequestModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: SlidingRequestConfiguration? = nil) -> UIViewController {
        let viewController = SlidingRequestViewController()
        let router = SlidingRequestRouter()
        let viewModel = SlidingRequestViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
