//
//  FullRequestViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class FullRequestViewController: BaseViewController, FullRequestViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: FullRequestViewOutput?

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
    // MARK: - FullRequestViewInput
    // ------------------------------

    func display(viewAdapter: FullRequestViewAdapter) { }

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
