//
//  BaseTargetType.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

protocol BaseTargetType: TargetType, TokenAuthorizable {}

extension BaseTargetType {
    
    public var baseURL: URL { URL(string: EnvConfigs.baseUrl)! }
    
    public var path: String { CommonConfigs.urlPath }
    
    public var method: Moya.Method { .post }
    
    public var sampleData: Data { Data() }
    
    public var headers: [String : String]? { nil }
    
    public var validate: Bool { true }
    
    public var requiredToken: Bool { true }
}
