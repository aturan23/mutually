//
//  FeatureManagerProtocol.swift
//  JuniorBank
//
//  Created by Turan Assylkhan on 19.01.2021.
//  Copyright © 2021 STRONG Team. All rights reserved.
//

protocol FeatureManagerProtocol: class {
    func getFeature(remoteType: RemoteConfigTypes, _ feature: FeatureType) -> Feature?
    func isFeatureActive(remoteType: RemoteConfigTypes, _ feature: FeatureType) -> Bool
}

final class FeatureManager: FeatureManagerProtocol {
    
    var remoteConfig: RemoteConfigServiceProtocol
    private var dict: [String: Any]?
    
    init(remoteConfig: RemoteConfigServiceProtocol) {
        self.remoteConfig = remoteConfig
        if let path = Bundle.main.path(forResource: "FeatureToggle", ofType: "plist") {
            self.dict = NSDictionary.init(contentsOfFile: path) as? [String : Any]
        }
    }
    
    func getFeature(remoteType: RemoteConfigTypes, _ feature: FeatureType) -> Feature? {
        let features = remoteConfig.getObjValue(key: remoteType.rawValue)
        guard let featureDict = features?[feature.rawValue] as? [String: Any]
                ?? dict?[feature.rawValue] as? [String: Any],
              let isActive = Bool.from(value: featureDict["enabled"]) else { return nil }
        let title = featureDict["title"] as? String
        var additional: String? = nil
        if let tempAdditional = featureDict["additional"] as? String, !tempAdditional.isEmpty {
            additional = tempAdditional
        }
        return Feature(type: feature, isActive: isActive, title: title, additional: additional)
    }
    
    func isFeatureActive(remoteType: RemoteConfigTypes, _ feature: FeatureType) -> Bool {
        let feature = getFeature(remoteType: remoteType, feature)
        return feature?.isActive ?? false
    }
}
