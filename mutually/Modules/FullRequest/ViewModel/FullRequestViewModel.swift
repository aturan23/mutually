//
//  FullRequestViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class FullRequestViewModel: FullRequestViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: FullRequestViewInput?
    var router: FullRequestRouterInput?
    weak var moduleOutput: FullRequestModuleOutput?

    // ------------------------------
    // MARK: - FullRequestViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: FullRequestViewAdapter())
    }
}

// ------------------------------
// MARK: - FullRequestModuleInput methods
// ------------------------------

extension FullRequestViewModel: FullRequestModuleInput {
    func configure(data: FullRequestConfigData) { }
}
