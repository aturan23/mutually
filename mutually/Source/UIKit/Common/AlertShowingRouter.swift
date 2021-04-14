//
//  AlertShowingRouter.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

typealias BaseErrorCompletion = (() -> Void)

protocol AlertShowingRouter {
    var alertFactory: AlertFactory { get }
    var viewController: UIViewController? { get set }
    func showAlert(title: String?, message: String?, completion: BaseErrorCompletion?)
    func showAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [AlertAction])
}

extension AlertShowingRouter {
    func showAlert(title: String? = "", message: String?, completion: BaseErrorCompletion? = nil) {
        let alert = alertFactory.makeDefault(title: title, message: message, actionHandler: completion)
        viewController?.present(alert, animated: true)
    }
    func showAlert(
        title: String? = "",
        message: String?,
        style: UIAlertController.Style = .alert,
        actions: [AlertAction] = []) {
        let alert = alertFactory.makeForActions(
            title: title, message: message, style: style, actions: actions)
        viewController?.present(alert, animated: true)
    }
}
