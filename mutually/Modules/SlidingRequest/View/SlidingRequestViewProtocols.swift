//
//  SlidingRequestViewProtocols.swift
//  mutually
//
//  Created by Turan Assylkhan on 04/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

protocol SlidingRequestViewInput: class, Loadable {
    func display(viewAdapter: SlidingRequestViewAdapter)
}

protocol SlidingRequestViewOutput {
    func didLoad()
    func didTapContinue(summ: String, term: String)
}
