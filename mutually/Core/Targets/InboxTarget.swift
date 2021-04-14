//
//  InboxTarget.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

import Moya

enum InboxTarget {
    case inbox(summ: String, term: String)
}

extension InboxTarget: BaseTargetType {
    var task: Task {
        switch self {
        case let .inbox(summ, term):
            return .requestParameters(
                parameters: [JSONRequestParameter.action.key: "new_inbox",
                             JSONRequestParameter.summ.key: summ,
                             JSONRequestParameter.term.key: term],
                encoding: URLEncoding.default)
        }
    }
}
