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
    
    func didTapButton(with form: RegistrationForm) {
        guard let phone = validate(form: form),
              form.dataProcessingSelected,
              form.termsSelected else {
            return
        }
        print(phone)
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func validate(form: RegistrationForm) -> String? {
        guard let phoneText = form.phone,
              phoneText.count == Constants.phoneOnlyDigitsLength else {
            view?.showError(phone: true, dataProcessing: !form.dataProcessingSelected, terms: !form.termsSelected)
            return nil
        }
        view?.showError(phone: false, dataProcessing: !form.dataProcessingSelected, terms: !form.termsSelected)
        return phoneText.substr(1)
    }
}
