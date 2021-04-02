//
//  SetupPasscodeModuleInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

/// Adapter struct for SetupPasscode initial configuration 
/// through SetupPasscodeModuleInput
struct SetupPasscodeConfigData { }

protocol SetupPasscodeModuleInput: class {
    var alertPresenter: AlertShowable? { get set }
}
