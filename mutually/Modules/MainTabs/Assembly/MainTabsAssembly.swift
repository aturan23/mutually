//
//  MainTabsAssembly.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias MainTabsConfiguration = (MainTabsModuleInput) -> MainTabsModuleOutput?

class MainTabsModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: MainTabsConfiguration? = nil) -> UIViewController {
        let viewController = MainTabsViewController()
        let router = MainTabsRouter()
        let viewModel = MainTabsViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
