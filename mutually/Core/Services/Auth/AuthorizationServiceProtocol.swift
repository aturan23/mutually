//
//  AuthorizationServiceProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol AuthorizationServiceProtocol: SmsServiceProtocol {
    var sessionTracker: SessionTrackerProtocol? { get set }
    func checkRegistrationStatusOf(phone: String,
                                   success: (( _ hasToken: Bool) -> Void)?,
                                   failure: ((NetworkError) -> Void)?)
    func registerUser(password: String,
                      success: (() -> Void)?,
                      failure: ((NetworkError) -> Void)?)
    func signIn(phone: String,
                password: String,
                success: (() -> Void)?,
                failure: ((NetworkError) -> Void)?)
    func changePasscode(current: String,
                        new: String,
                        success: ((String) -> Void)?,
                        failure: ((NetworkError) -> Void)?)
    func connect(success: (() -> Void)?,
                 failure: ((NetworkError) -> Void)?)
    func logOut(success: (() -> Void)?,
                failure: ((NetworkError) -> Void)?)
}
