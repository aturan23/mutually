//
//  AuthorizationTokenPlugin.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

import Moya

struct AuthorizationTokenPlugin: PluginType {
    
    init() {
        
    }
    
    /**
     Prepare a request by adding an device authorization header if necessary.

     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
//        guard
//            let target = target as? TokenAuthorizable
//        else {
//            return request
//        }
//        var request = request
//        target.requiredTokens.forEach { token in
//            request.addValue(token.value, forHTTPHeaderField: token.key)
//        }
        return request
    }
}
