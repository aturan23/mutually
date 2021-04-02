//
//  MainTabsViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class MainTabsViewModel: MainTabsViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: MainTabsViewInput?
    var router: MainTabsRouterInput?
    weak var moduleOutput: MainTabsModuleOutput?

    // ------------------------------
    // MARK: - MainTabsViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: MainTabsViewAdapter())
    }
}

// ------------------------------
// MARK: - MainTabsModuleInput methods
// ------------------------------

extension MainTabsViewModel: MainTabsModuleInput {
    func configure(data: MainTabsConfigData) { }
}
