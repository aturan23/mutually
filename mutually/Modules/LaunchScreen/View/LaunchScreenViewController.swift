//
//  LaunchScreenViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 14/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class LaunchScreenViewController: BaseViewController {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: LaunchScreenViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let imageView = UIImageView(image: Asset.logo.image)

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//            self?.output?.didLoad()
//        }
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        view.backgroundColor = .white

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        view.addSubview(imageView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
