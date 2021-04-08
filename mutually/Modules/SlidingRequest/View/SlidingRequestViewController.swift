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
        
        summSliderView.paragraph = "Сумма (до 1 млн.)"
        summSliderView.suffix = "₽"
        summSliderView.range = (min: 100000, max: 1000000)
        summSliderView.step = 10000
        summSliderView.value = 500000
        
        timeSliderView.paragraph = "Срок (до 4 лет)"
        timeSliderView.suffix = "мес."
        timeSliderView.range = (min: 12, max: 48)
        timeSliderView.value = 24

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
