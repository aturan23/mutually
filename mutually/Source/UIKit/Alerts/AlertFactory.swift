//
//  AlertFactory.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style = .default
    var handler: (() -> Void)?
}

final class AlertFactory {
    func makeDefault(title: String? = nil,
                                   message: String? = nil,
                                   actionTitle: String = "OK",
                                   actionHandler: (() -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle,
                                      style: .cancel,
                                      handler: { _ in actionHandler?() }))
        alert.view.tintColor = Color.mainNemo
        return alert
    }
    
    func makeForActions(title: String? = nil,
                        message: String? = nil,
                        style: UIAlertController.Style = .alert,
                        actions: [AlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { (action) in
            alert.addAction(UIAlertAction(
                title: action.title,
                style: action.style,
                handler: { _ in action.handler?() }
            ))
        }
        alert.view.tintColor = Color.mainNemo
        return alert
    }
}
