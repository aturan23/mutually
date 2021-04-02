//
//  BaseTargetType.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    public var baseURL: URL {
        return URL(string: EnvConfigs.baseUrl)!
    }
    
    public var path: String {
        return CommonConfigs.urlPath
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validate: Bool {
        return true
    }
}
