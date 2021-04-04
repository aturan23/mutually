//
//  SlidingRequestModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 04/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for SlidingRequest initial configuration 
/// through SlidingRequestModuleInput
struct SlidingRequestConfigData { }

/// Protocol with public methods to configure SlidingRequest 
/// from its parent module (usually implemented by this module's ViewModel)
protocol SlidingRequestModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: SlidingRequestConfigData)
}
