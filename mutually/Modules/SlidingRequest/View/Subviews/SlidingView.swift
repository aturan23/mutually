//
//  SlidingView.swift
//  mutually
//
//  Created by Turan Assylkhan on 05.04.2021.
//

import UIKit

class SlidingView: UIView {
    
    // MARK: - Public properties
    
    var paragraph: String? = nil {
        didSet {
            paragraphLabel.text = paragraph
        }
    }
    var suffix: String = ""
    var value: Float {
        get {slidingView.value }
        set {
            let stepped = round(newValue / step) * step
            slidingView.value = stepped
            titleLabel.text = "\(stepped.description)\(suffix.isEmpty ? "" : " \(suffix)")"
        }
    }
    var range: (min: Float, max: Float) = (min: 0, max: 100) {
        didSet {
            slidingView.minimumValue = range.min
            slidingView.maximumValue = range.max
        }
    }
    var step: Float = 1
    
    // MARK: - Private properties
    
    private let labelFactory = LabelFactory()
    
    // MARK: - UI components
    
    private lazy var paragraphLabel = labelFactory.make(
        withStyle: .paragraphSecondary,
        textColor: Color.textLowContrast,
        textAlignment: .center)
    private lazy var titleLabel = labelFactory.make(
        withStyle: .headingH1,
        textColor: Color.textHighContrast,
        textAlignment: .center)
    private let slidingView = UISlider()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    @objc private func sliderValueChanged(sender: UISlider) {
        value = sender.value
    }
    
    private func setupViews() {
        slidingView.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        [paragraphLabel, titleLabel, slidingView].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        paragraphLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(paragraphLabel.snp.bottom).offset(LayoutGuidance.offset)
            $0.centerX.equalToSuperview()
        }
        slidingView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(LayoutGuidance.offsetLarge)
            $0.width.bottom.equalToSuperview()
        }
    }
}
