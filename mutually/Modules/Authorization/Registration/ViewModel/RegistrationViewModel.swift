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
    weak var authorizationService: AuthorizationServiceProtocol?
    private var phone = ""
    
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
        self.phone = phone
        view?.startLoading()
        authorizationService?.getSmsPass(phone: phone, completion: { [weak self] (result) in
            guard let self = self else { return }
            self.view?.stopLoading()
            switch result {
            case .success: self.router?.showSmsVerification(phone: phone, moduleOutput: self)
            case .failure(let error): self.failureResponseHandler(error: error)
            }
        })
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func failureResponseHandler(error: NetworkError) {
        if case .networkFail = error { return }
        alertPresenter?.showMessageAlert(message: error.message)
    }
    
    private func validate(form: RegistrationForm) -> String? {
        guard let phoneText = form.phone,
              phoneText.count == Constants.phoneOnlyDigitsLength else {
            view?.showError(phone: true, dataProcessing: !form.dataProcessingSelected, terms: !form.termsSelected)
            return nil
        }
        view?.showError(phone: false, dataProcessing: !form.dataProcessingSelected, terms: !form.termsSelected)
        return phoneText
    }
}

// ------------------------------
// MARK: - SmsVerificationModuleOutput methods
// ------------------------------

extension RegistrationViewModel: SmsVerificationModuleOutput {
    func smsVerificationSucceeded(with data: [String : Any]?) {
        moduleOutput?.checkDidFindAlreadyRegistered(for: phone)
    }
}
