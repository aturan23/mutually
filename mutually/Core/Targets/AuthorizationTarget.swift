//
//  AuthorizationTarget.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

enum AuthorizationTarget {
    case getSmsPath(phone: String)
    case auth(phone: String, password: String)
    case firstScreen
}

extension AuthorizationTarget: BaseTargetType {
    
    var requiredToken: Bool {
        switch self {
        case .getSmsPath, .auth:
            return false
        default:
            return true
        }
    }
    
    var task: Task {
        switch self {
        case .getSmsPath(let phone):
            return .requestParameters(
                parameters: [JSONRequestParameter.action.key: "get_sms_pass",
                             JSONRequestParameter.login.key: phone,
                             "platform": "iOS"],
                encoding: URLEncoding.default)
        case let .auth(phone, password):
            return .requestParameters(
                parameters: [JSONRequestParameter.action.key: "auth",
                             JSONRequestParameter.login.key: phone,
                             JSONRequestParameter.password.key: password,
                             "platform": "iOS"],
                encoding: URLEncoding.default)
        case .firstScreen:
            return .requestParameters(
                parameters: [JSONRequestParameter.action.key: "getFirstScreen",
                             "platform": "iOS"],
                encoding: URLEncoding.default)
        }
    }
}
