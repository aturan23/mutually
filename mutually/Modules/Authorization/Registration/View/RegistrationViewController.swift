//
//  RegistrationViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 02/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController, RegistrationViewInput {
    
    private enum Constants {
        static let imageSize = CGSize(width: 312, height: 108)
    }

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: RegistrationViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let labelFactory = LabelFactory()
    private let imageView = UIImageView(image: Asset.logo.image)
    private lazy var titleLabel = labelFactory.make(
        withStyle: .paragraphBody,
        text: "Введите номер телефона, мы отправим вам СМС для подтверждения",
        textColor: .black)
    

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - RegistrationViewInput
    // ------------------------------

    func display(viewAdapter: RegistrationViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {


        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [imageView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(Constants.imageSize)
            $0.center.equalToSuperview()
        }
    }
}
