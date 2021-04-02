//
//  SessionTimeoutPlugin.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

final class SessionTimeoutPlugin: PluginType {
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case .success(let response):
//            if let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: []),
//                let json = jsonObject as? JSONStandard,
//                json[JSONResponseParameter.timeout.key] != nil {
//                    NotificationCenter.default.post(name: JBNotification.sessionDidTimeout.name, object: self)
//                }
            return result
        case .failure:
            return result
        }
    }
}
