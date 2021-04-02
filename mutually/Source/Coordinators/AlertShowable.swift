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
