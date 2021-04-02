//
//  AuthorizationTarget.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

enum AuthorizationTarget {
}

extension AuthorizationTarget: BaseTargetType {
    var task: Task {
        return .requestData(Data())
//        switch self {
//
//        }
    }
}
