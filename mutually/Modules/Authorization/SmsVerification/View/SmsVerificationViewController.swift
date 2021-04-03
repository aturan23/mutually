//
//  SmsVerificationViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class SmsVerificationViewController: BaseViewController, SmsVerificationViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: SmsVerificationViewOutput?

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
    // MARK: - SmsVerificationViewInput
    // ------------------------------

    func display(viewAdapter: SmsVerificationViewAdapter) { }

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
