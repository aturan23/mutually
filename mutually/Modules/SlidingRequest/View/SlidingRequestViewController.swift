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

    private let titleLabel = LabelFactory().make(
        withStyle: .paragraphBody,
        text: "Какую сумму и на какой срок вы хотите получить?",
        textColor: .black)
    
    private let summSliderView = SlidingView()
    private let timeSliderView = SlidingView()
    
    private let requestButton = Button.makePrimary(with: "Заявка")
    
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
        title = "Заявка"
        titleLabel.numberOfLines = 0
        
        summSliderView.paragraph = "Сумма (до 2 млн.)"
        summSliderView.suffix = "₽"
        summSliderView.range = (min: 0, max: 2000000)
        summSliderView.step = 100000
        summSliderView.value = 1000000
        
        summSliderView.paragraph = "Срок (до года)"
        summSliderView.suffix = "мес."
        summSliderView.range = (min: 1, max: 12)
        summSliderView.value = 6

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [titleLabel, summSliderView, timeSliderView, requestButton].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(LayoutGuidance.offsetSuperLarge)
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
        }
        summSliderView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
            $0.centerY.equalToSuperview().offset(-LayoutGuidance.offsetSuperLarge * 2)
        }
        timeSliderView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
            $0.top.equalTo(summSliderView.snp.bottom).offset(LayoutGuidance.offsetSuperLarge * 2)
        }
        requestButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).offset(-LayoutGuidance.offsetSuperLarge)
        }
    }
}
