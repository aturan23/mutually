//
//  RegistrationModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for Registration initial configuration 
/// through RegistrationModuleInput
struct RegistrationConfigData { }

/// from its parent module (usually implemented by this module's ViewModel)
protocol RegistrationModuleInput: class {
    var alertPresenter: AlertShowable? { get set }
}
