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
    private lazy var debouncingSessionUpdater = Debouncer(
        delay: Constants.sessionCheckInterval,
        callback: checkSession)
    
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
        checkSession()
        debouncingSessionUpdater.call()
    }
    
    func logOut(sessionTimeout: Bool) {
        guard isLoggedIn else { return }
        isLoggedIn = false
        goToPrelogin(sessionTimeout: sessionTimeout)
        authorizationService?.logOut(success: nil, failure: nil)
    }
    
    // MARK: - Private methods
    
    private func setupObserving() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sessionDidTimeout),
            name: MutuallyNotification.sessionDidTimeout.name,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkSession),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }
    
    @objc private func sessionDidTimeout() {
        logOut(sessionTimeout: true)
    }
    
    @objc private func checkSession() {
        guard isLoggedIn else { return }
        debouncingSessionUpdater.call()
        authorizationService?.connect(
            success: nil,
            failure: { [weak self] (error) in
                switch error {
                case .serverError:
                    self?.logOut(sessionTimeout: true)
                default:
                    return
                }
        })
    }
    
    private func goToPrelogin(sessionTimeout: Bool) {
        if shouldSuggestAlternativeLoginMethods || sessionTimeout {
            rootController.setupRootViewControllerAndSuggestAlternativeLoginMethods()
        } else {
            rootController.setupRootViewController()
        }
    }
}
