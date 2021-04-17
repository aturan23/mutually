//
//  FullRequestViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol FullRequestViewInput: class {
    func display(viewAdapter: FullRequestViewAdapter)
    func displayButton()
}

protocol FullRequestViewOutput {
    func didLoad()
    func buttonDidTap()
}
