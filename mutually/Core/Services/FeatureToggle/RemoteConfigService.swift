//
//  RemoteConfigService.swift
//  JuniorBank
//
//  Created by Turan Assylkhan on 19.01.2021.
//  Copyright © 2021 STRONG Team. All rights reserved.
//

import FirebaseRemoteConfig

/// Service abstraction to communicate with app's Remote Config cloud service
protocol RemoteConfigServiceProtocol {
    /// Triggers refetching config values from remote service
    func refetch()
    /// Retrieves an Integer value for a given string key from configs
    ///
    /// - Parameter key: Config Key string
    /// - Returns: Integer value stored for given Key, if exists
    func getStringValue(key: String) -> Int?
    /// Retrieves a Dictionary list for a given string key from configs
    ///
    /// - Parameter key: Config Key string
    /// - Returns: Dictionary list stored for given Key, if exists
    func getObjArrayValue(key: String) -> [[String: Any]]?
    /// Retrieves a swift dict for a given string key from configs
    ///
    /// - Parameter key: Config Key string
    /// - Returns: swift dict stored for given Key, if exists
    func getObjValue(key: String) -> [String: Any]?
}

class RemoteConfigService: RemoteConfigServiceProtocol {
    var firebaseConfig: RemoteConfig
    required init(firebaseConfig: RemoteConfig) {
        self.firebaseConfig = firebaseConfig
        resolveDefaultValues()
    }
    func refetch() {
        firebaseConfig.fetch(withExpirationDuration: GlobalConstants.defaultRemoteConfigInterval) { status, error in
            if status == .success {
                self.firebaseConfig.activate()
            }
        }
    }
    
    func getStringValue(key: String) -> Int? {
        return firebaseConfig.configValue(forKey: key).numberValue.intValue
    }
    
    func getObjArrayValue(key: String) -> [[String: Any]]? {
        let configData = firebaseConfig.configValue(forKey: key)
        guard let jsonString = configData.stringValue?.data(using: .utf8)
            else { return nil }
        do {
            let json = try JSONSerialization.jsonObject(
                with: jsonString,
                options: JSONSerialization.ReadingOptions.allowFragments)
            return json as? [[String: Any]]
        } catch {
            return nil
        }
    }
    
    func getObjValue(key: String) -> [String: Any]? {
        let configData = firebaseConfig.configValue(forKey: key)
        guard let jsonString = configData.stringValue?.data(using: .utf8)
            else { return nil }
        do {
            let json = try JSONSerialization.jsonObject(
                with: jsonString,
                options: JSONSerialization.ReadingOptions.allowFragments)
            return json as? [String: Any]
        } catch {
            return nil
        }
    }
    
    private func resolveDefaultValues() {
        firebaseConfig.setDefaults(fromPlist: "FeatureToggle")
    }
}
