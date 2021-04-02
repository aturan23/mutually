//
//  SetupPasscodeViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class SetupPasscodeViewModel: SetupPasscodeViewOutput, SetupPasscodeModuleInput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    var alertPresenter: AlertShowable?
    weak var view: SetupPasscodeViewInput?
    var router: SetupPasscodeRouterInput?
    weak var moduleOutput: SetupPasscodeModuleOutput?

    // ------------------------------
    // MARK: - SetupPasscodeViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SetupPasscodeViewAdapter())
    }
}
