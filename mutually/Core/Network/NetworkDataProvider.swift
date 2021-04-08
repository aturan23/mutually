//
//  NetworkDataProvider.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

final class NetworkDataProvider<Target: TargetType> {
    typealias Completion = (Result<Moya.Response, NetworkError>) -> Void
    
    private let networkReachibilityChecker: NetworkReachabilityChecking?
    private let dataProvider: MoyaProvider<Target>
    
    init(networkReachibilityChecker: NetworkReachabilityChecking?,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         plugins: [PluginType] = []) {
        self.networkReachibilityChecker = networkReachibilityChecker
        dataProvider = MoyaProvider(stubClosure: stubClosure, plugins: plugins)
    }
    
    func request<T: Codable>(_ target: Target, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard networkReachibilityChecker?.isReachable == true else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationCenter.default.post(name: MutuallyNotification.networkFailed.name, object: nil)
                completion(.failure(.networkFail))
            }
            return
        }
        dataProvider.request(target) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                completion(self.decode(response))
            case .failure(let error):
                if let reason = error.failureReason {
                    completion(.failure(.serverError(reason: reason)))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func request(_ target: Target, completion: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        guard networkReachibilityChecker?.isReachable == true else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationCenter.default.post(name: MutuallyNotification.networkFailed.name, object: nil)
                completion(.failure(.networkFail))
            }
            return
        }
        dataProvider.request(target) { (result) in
            switch result {
            case .success(let response):
                if let netResponse = try? response.map(NetworkResponse.self) {
                    completion(.success(netResponse))
                    return
                }
                completion(.failure(.incorrectJSON))
            case .failure(let error):
                if let reason = error.failureReason {
                    completion(.failure(.serverError(reason: reason)))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
    }
    
    private func decode<T: Codable>(_ response: Response) -> Result<T, NetworkError> {
        if let data = String(decoding: response.data, as: UTF8.self).data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let _ = jsonObject as? JSONStandard,
           let result = try? response.map(NetworkResponse.self) {
            let response = try? response.map(T.self)
            if let response = response, result.result {
                return .success(response)
            }
            var networkError: NetworkError = .unknownError
            if let response = result.code {
                networkError = .serverError(reason: response)
            }
            return .failure(networkError)
        } else {
            return .failure(.incorrectJSON)
        }
    }
}
