//
//  SlidingRequestViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 04/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class SlidingRequestViewModel: SlidingRequestViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SlidingRequestViewInput?
    var router: SlidingRequestRouterInput?
    weak var moduleOutput: SlidingRequestModuleOutput?

    // ------------------------------
    // MARK: - SlidingRequestViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SlidingRequestViewAdapter())
    }
}

// ------------------------------
// MARK: - SlidingRequestModuleInput methods
// ------------------------------

extension SlidingRequestViewModel: SlidingRequestModuleInput {
    func configure(data: SlidingRequestConfigData) { }
}
