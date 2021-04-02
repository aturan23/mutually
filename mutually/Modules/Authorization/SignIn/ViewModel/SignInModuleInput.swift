//
//  SignInModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for SignIn initial configuration 
/// through SignInModuleInput
struct SignInConfigData {
    var phone: String
}

/// Protocol with public methods to configure SignIn 
/// from its parent module (usually implemented by this module's ViewModel)
protocol SignInModuleInput: class {
    var alertPresenter: AlertShowable? { get set }
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: SignInConfigData)
}
