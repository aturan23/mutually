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
        navigationController = UINavigationController.makeDefault()
    }
    
    // MARK: - RegistrationCoordinating
    
    func start() {
        guard let launchScreen = injection
                .inject(LaunchScreenModuleAssembly.self)?
                .assemble(self) else { return }
        
        window.rootViewController = launchScreen
    }
    
    private func stupSignIn() {
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
    }
    
    func showSlidingView() {
        guard let slidingViewModule = injection
                .inject(SlidingRequestModuleAssembly.self)?
                .assemble({ _ in
                    return self
                }) else {
            return
        }
        
        window.rootViewController = slidingViewModule
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromRight],
                          animations: nil,
                          completion: nil)
    }
    
    func showThanksPage(screen: FirstScreenResponse?) {
        guard let fullRequestModule = injection
                .inject(FullRequestModuleAssembly.self)?
                .assemble({ moduleInput in
                    moduleInput.configure(data: .init(photos: screen?.photos, title: screen?.text))
                    return nil
                }) else {
            return
        }
        navigationController.setViewControllers([fullRequestModule], animated: false)
        window.rootViewController = navigationController
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

extension RegistrationCoordinator: RegistrationModuleOutput, SlidingRequestModuleOutput, LaunchScreenModuleOutput {
    
    func moveToPage(screen: FirstScreenResponse?) {
        switch screen?.screen {
        case .newClient:
            showSlidingView()
        case .thanks:
            showThanksPage(screen: screen)
        case .none:
            stupSignIn()
        default: break
        }
    }
}
