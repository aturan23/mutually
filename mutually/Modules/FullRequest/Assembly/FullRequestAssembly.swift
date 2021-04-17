//
//  FullRequestAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias FullRequestConfiguration = (FullRequestModuleInput) -> FullRequestModuleOutput?

class FullRequestModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: FullRequestConfiguration? = nil) -> UIViewController {
        let viewController = FullRequestViewController()
        let router = FullRequestRouter()
        let viewModel = FullRequestViewModel()
        viewModel.view = viewController
        viewModel.router = router
        viewModel.imageService = injection.inject(ImageServiceProtocol.self)
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
