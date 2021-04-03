//
//  SessionTracker.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

final class SessionTracker: SessionTrackerProtocol {
    enum Constants {
        static let sessionCheckInterval = TimeInterval.minute
    }
    
    // MARK: - Properties
    
    private(set) var isLoggedIn: Bool = false
    var shouldSuggestAlternativeLoginMethods: Bool = false
    
    private let rootController: RootUIControllerType
    private let userDefaults: UserDefaults?
    private let authorizationService: AuthorizationServiceProtocol?
    
    // MARK: - Init
    
    init(rootController: RootUIControllerType,
         userDefaults: UserDefaults?,
         authorizationService: AuthorizationServiceProtocol?) {
        self.rootController = rootController
        self.userDefaults = userDefaults
        self.authorizationService = authorizationService
        setupObserving()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public methods
    
    func didLogin() {
        isLoggedIn = true
    }
    
    func logOut(sessionTimeout: Bool) {
        guard isLoggedIn else { return }
        isLoggedIn = false
        goToPrelogin(sessionTimeout: sessionTimeout)
    }
    
    // MARK: - Private methods
    
    private func setupObserving() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sessionDidTimeout),
            name: MutuallyNotification.sessionDidTimeout.name,
            object: nil)
    }
    
    @objc private func sessionDidTimeout() {
        logOut(sessionTimeout: true)
    }
    
    private func goToPrelogin(sessionTimeout: Bool) {
        if shouldSuggestAlternativeLoginMethods || sessionTimeout {
            rootController.setupRootViewControllerAndSuggestAlternativeLoginMethods()
        } else {
            rootController.setupRootViewController()
        }
    }
}
