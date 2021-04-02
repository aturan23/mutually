//
//  Feature.swift
//  JuniorBank
//
//  Created by Turan Assylkhan on 19.01.2021.
//  Copyright © 2021 STRONG Team. All rights reserved.
//

enum FeatureType: String {
    case banner
}

enum RemoteConfigTypes: String {
    case features
}

struct Feature {
    var type: FeatureType
    var isActive: Bool
    var title: String?
    var additional: String?
}
