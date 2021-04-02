//
//  AuthorizationTarget.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

enum AuthorizationTarget {
    case getSmsPath(phone: String)
}

extension AuthorizationTarget: BaseTargetType {
    var task: Task {
        switch self {
        case .getSmsPath(let phone):
            return .requestParameters(
                parameters: [JSONRequestParameter.action.key: "get_sms_pass",
                             JSONRequestParameter.login.key: phone],
                encoding: URLEncoding.default)
        }
    }
}
