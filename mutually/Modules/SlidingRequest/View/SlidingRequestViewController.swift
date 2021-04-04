//
//  SlidingRequestViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 04/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class SlidingRequestViewController: BaseViewController, SlidingRequestViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: SlidingRequestViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - SlidingRequestViewInput
    // ------------------------------

    func display(viewAdapter: SlidingRequestViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {


        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {

    }

    private func setupConstraints() {
        
    }
}
