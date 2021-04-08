//
//  SmsServiceProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol SmsServiceProtocol: class {
    func requestSMSCode(completion: @escaping (Result<Void, NetworkError>) -> ())
    func confirmSMSCode(code: String,
                        completion: @escaping (Result<Codable?, NetworkError>) -> ())
}
