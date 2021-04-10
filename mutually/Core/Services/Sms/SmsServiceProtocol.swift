//
//  SmsServiceProtocol.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

protocol SmsServiceProtocol: class {
    func requestSMSCode(completion: @escaping ResponseCompletion<Void>)
    func confirmSMSCode(code: String,
                        completion: @escaping ResponseCompletion<Codable?>)
}
