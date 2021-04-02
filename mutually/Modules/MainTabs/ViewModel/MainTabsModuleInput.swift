//
//  MainTabsModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for MainTabs initial configuration 
/// through MainTabsModuleInput
struct MainTabsConfigData { }

/// Protocol with public methods to configure MainTabs 
/// from its parent module (usually implemented by this module's ViewModel)
protocol MainTabsModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: MainTabsConfigData)
}
