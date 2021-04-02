//
//  SignInViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol SignInViewInput: class {
    func display(viewAdapter: SignInViewAdapter)
}

protocol SignInViewOutput {
    func didLoad()
}
