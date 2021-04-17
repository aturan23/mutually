//
//  AuthorizationTokenPlugin.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

import Moya

protocol TokenAuthorizable {
    var requiredToken: Bool { get }
}

struct AuthorizationTokenPlugin: PluginType {
    
    private let registeredUserHandler: RegisteredUserHandlerProtocol?
    
    init(registeredUserHandler: RegisteredUserHandlerProtocol?) {
        self.registeredUserHandler = registeredUserHandler
    }
    
    /**
     Prepare a request by adding an device authorization header if necessary.

     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? TokenAuthorizable,
              target.requiredToken,
              let token =  registeredUserHandler?.currentUser?.token,
              let httpBody = request.httpBody else { return request }
        var request = request
        let body = String(data: httpBody, encoding: .utf8)! + "&token=\(token)"
        request.httpBody = Data(body.utf8)
        return request
    }
}
