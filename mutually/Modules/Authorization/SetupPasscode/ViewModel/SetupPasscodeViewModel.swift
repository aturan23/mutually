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
    var authorizationService: AuthorizationServiceProtocol?
    private var createdPasscode: String?

    // ------------------------------
    // MARK: - SetupPasscodeViewOutput methods
    // ------------------------------

    func didCreate(passcode: String) {
        guard validateSimplicity(passcode: passcode) else {
            view?.showError(adapter: .init(errorType: .tooSimplePasscode))
            return
        }
        view?.showRepeat()
        createdPasscode = passcode
    }
    
    func didTryToRepeat(passcode: String) {
        guard let createdPasscode = createdPasscode,
            createdPasscode == passcode
            else {
                self.createdPasscode = nil
                view?.showError(adapter: .init(errorType: .passcodeMismatch))
                return
        }
        view?.startLoading()
        authorizationService?.registerUser(password: passcode, completion: { [weak self] (result) in
            self?.view?.stopLoading()
            switch result {
            case .success:
                self?.moduleOutput?.setupPasscodeSucceeded(passcode: passcode)
            case .failure(let error):
                self?.alertPresenter?.showDefaultAlert(message: error.message, actionTitle: "OK", actionHandler: {
                    self?.view?.showCreate()
                })
            }
        })
    }
    
    private func validateSimplicity(passcode: String) -> Bool {
        return !StringUtils.allEqual(string: passcode)
            && !StringUtils.isConsecutiveDigits(string: passcode)
    }
}
