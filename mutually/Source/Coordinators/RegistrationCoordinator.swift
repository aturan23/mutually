//
//  RegistrationCoordinator.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

class RegistrationCoordinator: RegistrationCoordinating {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let injection: ModuleInjecting
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(window: UIWindow, injection: ModuleInjecting) {
        self.window = window
        self.injection = injection
        navigationController = UINavigationController()
    }
    
    // MARK: - RegistrationCoordinating
    
    func start() {
        guard
            let registrationViewController = injection
                .inject(RegistrationModuleAssembly.self)?
                .assemble ({ [weak self] moduleInput in
                    moduleInput.alertPresenter = self
                    return self
                })
            else {
                return
        }
        navigationController.setViewControllers([registrationViewController], animated: false)
        
        let transition: () -> Void = { self.window.rootViewController = self.navigationController }
        if let previousViewController = window.rootViewController {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: transition)
            previousViewController.dismiss(animated: false) {
                previousViewController.view.removeFromSuperview()
            }
        } else {
            transition()
        }
        
        if let registeredUserHandler = injection.inject(RegisteredUserHandlerProtocol.self),
            let registeredUserData = registeredUserHandler.currentUser,
            registeredUserData.shouldAutoLogin {
            let configData = SignInConfigData(phone: registeredUserData.phone)
            moveToSignIn(data: configData, animating: false)
        }
    }
    
    func moveToSignIn(data: SignInConfigData, animating: Bool) {
        guard
            let signInViewController = injection
                .inject(SignInModuleAssembly.self)?
                .assemble({ [weak self] moduleInput in
                    moduleInput.alertPresenter = self
                    moduleInput.configure(data: data)
                    return self
                })
            else {
                return
        }
        navigationController.pushViewController(signInViewController, animated: animating)
    }
    
    func moveToSetupPasscode() {
        guard let setupPasscodeViewController = injection
            .inject(SetupPasscodeModuleAssembly.self)?
            .assemble({ [weak self] moduleInput in
                moduleInput.alertPresenter = self
                return self
            })
            else {
                return
        }
        navigationController.pushViewController(setupPasscodeViewController, animated: true)
    }
    
    func showMainPage() {
        guard let mainTabBarController = injection
            .inject(MainTabsModuleAssembly.self)?
            .assemble() else {
            return
        }
        
        window.rootViewController = mainTabBarController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromRight],
                          animations: nil,
                          completion: nil)
    }
}

extension RegistrationCoordinator: AlertShowable {
    func showDefaultAlert(title: String?, message: String?, actionTitle: String, actionHandler: (() -> ())?) {
        let alert = AlertFactory()
            .makeDefault(title: title,
                                       message: message,
                                       actionTitle: actionTitle,
                                       actionHandler: actionHandler)
        window.topMostViewController?.present(alert, animated: true)
    }
    
    func showMessageAlert(title: String?, message: String) {
        let alert = AlertFactory().makeDefault(title: title, message: message)
        window.topMostViewController?.present(alert, animated: true)
    }
    
    func showAlert(title: String?,
                   message: String?,
                   actionsDescriptions: [AlertAction]) {
        let alert = AlertFactory().makeForActions(
            title: title,
            message: message,
            actions: actionsDescriptions)
        window.topMostViewController?.present(alert, animated: true)
    }
}

extension RegistrationCoordinator: RegistrationModuleOutput {
    
    func checkDidFindAlreadyRegistered(for phone: String) {
        moveToSignIn(data: SignInConfigData(phone: phone),
                     animating: true)
    }
    
    func checkDidFindLocallyRegistered() {
        guard
            let userData = injection
                .inject(RegisteredUserHandlerProtocol.self)?
                .currentUser
            else {
                return
        }
        let configData = SignInConfigData(phone: userData.phone)
        moveToSignIn(data: configData, animating: true)
    }

}

extension RegistrationCoordinator: SetupPasscodeModuleOutput {
    func setupPasscodeSucceeded(passcode: String) {
        showMainPage()
    }
}

extension RegistrationCoordinator: SignInModuleOutput {
    func signInSucceeded(with passcode: String) {
        showMainPage()
    }
    
    func signInDidSelectExit() {
        navigationController.popToRootViewController(animated: true)
    }
}
