//
//  LaunchScreenViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 14/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class LaunchScreenViewModel: LaunchScreenViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    var moduleOutput: LaunchScreenModuleOutput
    var authService: AuthorizationServiceProtocol?
    
    init(moduleOutput: LaunchScreenModuleOutput) {
        self.moduleOutput = moduleOutput
    }

    // ------------------------------
    // MARK: - LaunchScreenViewOutput methods
    // ------------------------------

    func didLoad() {
        authService?.getFirstScreen(completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.moduleOutput.moveToPage(screen: response)
            case .failure:
                self?.moduleOutput.moveToPage(screen: nil)
            }
        })
    }
}
