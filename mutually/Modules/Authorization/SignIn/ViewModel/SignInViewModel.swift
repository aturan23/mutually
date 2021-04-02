//
//  SignInViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class SignInViewModel: SignInViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    var alertPresenter: AlertShowable?
    weak var view: SignInViewInput?
    var router: SignInRouterInput?
    weak var moduleOutput: SignInModuleOutput?

    // ------------------------------
    // MARK: - SignInViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SignInViewAdapter())
    }
}

// ------------------------------
// MARK: - SignInModuleInput methods
// ------------------------------

extension SignInViewModel: SignInModuleInput {
    func configure(data: SignInConfigData) { }
}
