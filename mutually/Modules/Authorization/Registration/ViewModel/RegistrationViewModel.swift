//
//  RegistrationViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class RegistrationViewModel: RegistrationViewOutput, RegistrationModuleInput {
    
    private enum Constants {
        static let phoneOnlyDigitsLength: Int = 11
    }
    
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
    
    func didTapButton() {
        guard let phone = getPhoneValidatingCompleteness() else {
            return
        }
        print(phone)
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func getPhoneValidatingCompleteness() -> String? {
        guard let phoneText = view?.getPhoneFieldText().onlyDigits,
              phoneText.count == Constants.phoneOnlyDigitsLength else {
            view?.phoneError()
            return nil
        }
        return phoneText.substr(1)
    }
}
