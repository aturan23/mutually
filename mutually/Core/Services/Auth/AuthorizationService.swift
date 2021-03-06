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
    
    func requestSMSCode(completion: @escaping ResponseCompletion<Void>) {
        guard let phone = dataService?.phone else {
            completion(.failure(.unknownError))
            return
        }
        dataProvider.request(.getSmsPath(phone: phone)) { (result) in
            switch result {
            case .success(let response):
                if response.result {
                    completion(.success(()))
                    return
                }
                completion(.failure(.unknownError))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func confirmSMSCode(code: String,
                        completion: @escaping ResponseCompletion<Codable?>) {
        guard let phone = dataService?.phone else {
            completion(.failure(.unknownError))
            return
        }
        dataProvider.request(.auth(phone: phone, password: code)) { [weak self] (result: ResponseResult<TokenResponse>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.dataService?.token = response.data.hash
                let registeredUserData = RegisteredUserData(phone: phone,
                                                            token: response.data.hash)
                self.registeredUserHandler?.set(userData: registeredUserData)
                self.sessionTracker?.didLogin()
                self.getFirstScreen { (result) in
                    switch result {
                    case .success(let model): completion(.success(model))
                    case .failure(let error): completion(.failure(error))
                    }
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func getFirstScreen(completion: @escaping ResponseCompletion<FirstScreenResponse>) {
        dataProvider.request(.firstScreen) { (result: ResponseResult<FirstScreenResponse>) in
            completion(result)
        }
    }
}
