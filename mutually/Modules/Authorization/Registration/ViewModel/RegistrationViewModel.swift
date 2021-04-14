//
//  RegistrationViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import Foundation
import UIKit

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
    var dataService: DataServiceProtocol?
    weak var authorizationService: AuthorizationServiceProtocol?
    private var phone = ""
    
    // ------------------------------
    // MARK: - RegistrationViewOutput methods
    // ------------------------------
    
    func didLoad() {
        view?.display(viewAdapter: buildAdapter())
    }
    
    func didTapButton(with form: RegistrationForm) {
        guard let phone = validate(form: form),
              form.dataProcessingSelected else { return }
        self.phone = phone
        dataService?.phone = phone
        router?.routeToSmsVerification(phone: self.phone, moduleOutput: self)
    }
    
    func didTapLink() {
        router?.routeToWebView()
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func validate(form: RegistrationForm) -> String? {
        guard let phoneText = form.phone,
              phoneText.count == Constants.phoneOnlyDigitsLength else {
            view?.showError(phone: true, dataProcessing: !form.dataProcessingSelected)
            return nil
        }
        view?.showError(phone: false, dataProcessing: !form.dataProcessingSelected)
        return phoneText
    }
    
    private func buildAdapter() -> RegistrationViewAdapter {
        let text = "Соглашение на обработку персональных данных"
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.font: UIFont.regular(size: 15)])
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        return .init(dataProcessingAttributes: attributedText)
    }
}

// ------------------------------
// MARK: - SmsVerificationModuleOutput methods
// ------------------------------

extension RegistrationViewModel: SmsVerificationModuleOutput {
    func smsVerificationSucceeded(with data: Codable?) {
        moduleOutput?.moveToPage(screen: data as? FirstScreenResponse)
    }
}
