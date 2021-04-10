//
//  GlobalConstants.swift
//  mutually
//
//  Created by Turan Assylkhan on 06.04.2021.
//

import Foundation

typealias ResponseCompletion<T> = (Result<T, NetworkError>) -> Void

enum GlobalConstants {
    
    enum API {
        static let baseUrl = URL(string: EnvConfigs.baseUrl)!
        
        static let agreementUrl = baseUrl.appendingPathComponent(CommonConfigs.agreement)
    }
}
