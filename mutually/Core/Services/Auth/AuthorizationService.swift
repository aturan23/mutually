//
//  AuthorizationService.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

final class AuthorizationService: AuthorizationServiceProtocol {

    // MARK: - Properties
    
    private let dataProvider: NetworkDataProvider<AuthorizationTarget>
    private var tokenWrapper: RegistrationTokenWrapper?
    private var dataService: DataServiceProtocol?
    private let registeredUserHandler: RegisteredUserHandlerProtocol?
    weak var sessionTracker: SessionTrackerProtocol?
    
    // MARK: - Init
    
    init(dataProvider: NetworkDataProvider<AuthorizationTarget>,
         dataService: DataServiceProtocol?,
         registeredUserHandler: RegisteredUserHandlerProtocol?) {
        self.dataProvider = dataProvider
        self.dataService = dataService
        self.registeredUserHandler = registeredUserHandler
    }
    
    // MARK: - AuthorizationServiceProtocol
    
    func checkRegistrationStatusOf(
        phone: String,
        success: (( _ hasToken: Bool) -> Void)?,
        failure: ((NetworkError) -> Void)?
    ) {
//        dataProvider.request(.checkRegistrationStatus(phone: phone)) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                guard let statusWrapper = try? response.map(RegistrationStatus.Response.self) else {
//                    failure?(.unknownError)
//                    return
//                }
//                self.tokenWrapper = try? response.map(RegistrationTokenWrapper.self)
//                if var userDataModel = try? response.map(UserDataModel.self),
//                    userDataModel.birthDate != nil {
//                    userDataModel.phone = phone
//                    self.dataService?.user = userDataModel
//                }
//                switch statusWrapper.status {
//                case .canRegister:
//                    guard
//                        self.tokenWrapper != nil,
//                        self.dataService?.user?.birthDate != nil else {
//                            failure?(.unknownError)
//                            return
//                    }
//                    success?(statusWrapper.status, true)
//                case .alreadyRegistered:
//                    let hasToken = self.tokenWrapper != nil
//                        && self.dataService?.user?.birthDate != nil
//                    success?(statusWrapper.status, hasToken)
//                case .notExists:
//                    success?(statusWrapper.status, false)
//                }
//            case .failure(let error):
//                self.tokenWrapper = nil
//                failure?(error)
//            }
//        }
    }
    
    func requestSMSCode(completion: @escaping (Result<Void, NetworkError>) -> ()) {
        guard let phone = dataService?.phone else {
            completion(.failure(.unknownError))
                return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print(phone)
            completion(.success(()))
        }
//        dataProvider.request(
//            .getSmsPath(phone: phone)
//        ) { result in
//            switch result {
//            case .success:
//                completion(.success(()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
    func confirmSMSCode(code: String,
                        completion: @escaping (Result<JSONStandard?, NetworkError>) -> ()) {
//        guard let token = tokenWrapper?.token,
//            let phone = dataService?.user?.phone,
//            let status = dataService?.user?.status else {
//            completion(.failure(.unknownError))
//                return
//        }
//        dataProvider.request(
//            .confirmSmsCode(token: token, code: code, phone: phone, status: status)
//        ) { result in
//            switch result {
//            case .success:
//                completion(.success(nil))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
    func registerUser(password: String,
                      success: (() -> Void)?,
                      failure: ((NetworkError) -> Void)?) {
//        guard let token = tokenWrapper?.token,
//            let status = dataService?.user?.status,
//            let phone = dataService?.user?.phone else {
//                failure?(.unknownError)
//                return
//        }
//        let deviceId = OnboardingDevice.getDeviceId()
//        dataProvider.request(
//            .registerUser(status: status,
//                          token: token,
//                          password: password,
//                          deviceId: deviceId)
//        ) { [weak self] result in
//            switch result {
//            case .success:
//                let registeredUserData = RegisteredUserData(
//                    phone: phone,
//                    firstname: self?.dataService?.user?.firstname)
//                self?.registeredUserHandler?.set(userData: registeredUserData)
//                self?.signIn(phone: phone,
//                             password: password,
//                             success: { _ in success?() },
//                             failure: { _ in success?() })
//            case .failure(let error):
//                failure?(error)
//            }
//        }
    }
    
    func signIn(phone: String,
                password: String,
                success: (() -> Void)?,
                failure: ((NetworkError) -> Void)?) {
//        let deviceInfo = constructDeviceInfo()
//        dataProvider.request(
//            .signIn(phone: phone, password: password, deviceId: deviceId, deviceInfo: deviceInfo)
//        ) { [weak self] result in
//            switch result {
//            case .success(let response):
//                if let dict = try? response.mapJSON() as? NSDictionary,
//                    let verified = dict.value(forKey: JSONResponseParameter.verified.key) as? Bool,
//                    !verified {
//
//                    if let token = dict.value(forKey: JSONResponseParameter.token.key) as? String {
//                        success?(.notVerified(smsToken: token))
//                    } else {
//                        failure?(.unknownError)
//                    }
//                    return
//                }
//
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let userDataModel = try? decoder.decode(UserDataModel.self,
//                                                           from: response.data) {
//                    self?.dataService?.user = userDataModel
//
//                }
//                let registeredUserData = RegisteredUserData(
//                    phone: phone,
//                    firstname: self?.dataService?.user?.firstname)
//                self?.registeredUserHandler?.set(userData: registeredUserData)
//                self?.sessionTracker?.didLogin()
//                success?(.verified)
//            case .failure(let error):
//                failure?(error)
//            }
//        }
    }
    
    func changePasscode(current: String, new: String, success: ((String) -> Void)?, failure: ((NetworkError) -> Void)?) {
//        dataProvider.request(
//            .changePasscode(current: current, new: new)
//        ) { (result) in
//            switch result {
//            case .success(let response):
//                if let data = String(decoding: response.data, as: UTF8.self).data(using: .utf8),
//                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
//                    let json = jsonObject as? JSONStandard {
//                    if let succeed = json[JSONResponseParameter.success.key] as? Bool,
//                       succeed,
//                       let reason = json[JSONResponseParameter.reason.key] as? String {
//                        success?(reason)
//                        return
//                    }
//                    let reason = json[JSONResponseParameter.reason.key] as? String
//                    let networkError: NetworkError = reason == nil
//                        ? .unknownError
//                        : .serverError(reason: reason!)
//                    failure?(networkError)
//                } else {
//                    failure?(.incorrectJSON)
//                }
//            case .failure(let error):
//                failure?(error)
//            }
//        }
    }
    
    func connect(success: (() -> Void)?, failure: ((NetworkError) -> Void)?) {
//        dataProvider.request(.connect) { [weak self] (result) in
//            switch result {
//            case .success(let response):
//                let sessionCode = try? response.mapString(atKeyPath: "session_code")
//                self?.dataService?.sessionCode = sessionCode
//                success?()
//            case .failure(let error):
//                failure?(error)
//            }
//        }
    }
    
    private func constructDeviceInfo() -> String {
        return [("p",          "iOS\(UIDevice.current.systemVersion)")]
            .map { "\($0.0):\($0.1);" }
            .joined()
    }
}
