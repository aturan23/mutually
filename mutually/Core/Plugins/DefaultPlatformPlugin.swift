//
//  DefaultPlatformPlugin.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

import Moya

struct DefaultPlatformPlugin: PluginType {
    
    /**
     Prepare a request by adding a platform parameter.

     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        let body = String(data: request.httpBody!, encoding: .utf8)! + "&platform=iOS"
        request.httpBody = Data(body.utf8)
        return request
    }
}
