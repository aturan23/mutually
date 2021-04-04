//
//  SetupPasscodeViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol SetupPasscodeViewInput: class {
    func showCreate()
    func showRepeat()
    func showError(adapter: SetupPasscodeViewAdapter)
    func startLoading()
    func stopLoading()
}

protocol SetupPasscodeViewOutput {
    func didCreate(passcode: String)
    func didTryToRepeat(passcode: String)
}
