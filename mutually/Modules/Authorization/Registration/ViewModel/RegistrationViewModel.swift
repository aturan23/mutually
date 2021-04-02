//
//  RegistrationViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class RegistrationViewModel: RegistrationViewOutput, RegistrationModuleInput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    var alertPresenter: AlertShowable?
    weak var view: RegistrationViewInput?
    var router: RegistrationRouterInput?
    weak var moduleOutput: RegistrationModuleOutput?

    // ------------------------------
    // MARK: - RegistrationViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: RegistrationViewAdapter())
    }
}
