//
//  AlertShowable.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol AlertShowable: class {
    func showDefaultAlert(
        title: String?,
        message: String?,
        actionTitle: String,
        actionHandler: (() -> ())?
    )
    func showMessageAlert(title: String?, message: String)
    func showAlert(
        title: String?,
        message: String?,
        actionsDescriptions: [AlertAction]
    )
}

extension AlertShowable {
    func showDefaultAlert(
        title: String? = nil,
        message: String?,
        actionTitle: String,
        actionHandler: (() -> ())? = nil
    ) {
        showDefaultAlert(title: title, message: message, actionTitle: actionTitle, actionHandler: actionHandler)
    }
    func showMessageAlert(title: String? = nil, message: String) {
        showMessageAlert(title: title, message: message)
    }
    func showAlert(
        title: String? = nil,
        message: String?,
        actionsDescriptions: [AlertAction] = []
    ) {
        showAlert(title: title, message: message, actionsDescriptions: actionsDescriptions)
    }
}
