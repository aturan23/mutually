//
//  FullRequestModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for FullRequest initial configuration 
/// through FullRequestModuleInput
struct FullRequestConfigData { }

/// Protocol with public methods to configure FullRequest 
/// from its parent module (usually implemented by this module's ViewModel)
protocol FullRequestModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: FullRequestConfigData)
}
