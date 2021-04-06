//
//  CheckBoxView.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

class CheckBoxView: UIView, UITextViewDelegate {
    
    var checkBoxTap: ((Bool) -> Void)?
    var textTap: (() -> Void)?
    
    var isChecked: Bool = false {
        didSet {
            selectedImageView.isHidden = !isChecked
        }
    }
    var title: String? {
        get { return titleTextLabel.text }
        set {
            titleTextLabel.text = newValue
            updateCheckboxConstraintsIfNeeded()
        }
    }
    var attributedTitle: NSAttributedString? {
        get { return titleTextLabel.attributedText }
        set {
            titleTextLabel.attributedText = newValue
            updateCheckboxConstraintsIfNeeded()
        }
    }
    
    private var titleTextLabel = LabelFactory().make(
        withStyle: .paragraphCaptionCaps,
        textColor: .black)
    private let checkboxView = UIView()
    private let selectedImageView: UIImageView = {
        let imageView = UIImageView(image: Asset.iconCheckboxSelected.image)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        let textGesture = UITapGestureRecognizer(target: self, action: #selector(didTapText))
        titleTextLabel.numberOfLines = 0
        titleTextLabel.isUserInteractionEnabled = true
        titleTextLabel.addGestureRecognizer(textGesture)
        
        
        let checkBoxGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkboxView.addGestureRecognizer(checkBoxGesture)
        
        selectedImageView.isHidden = !isChecked
        
        checkboxView.layer.cornerRadius = 8
        checkboxView.layer.borderWidth = 1
        checkboxView.layer.borderColor = Color.buttonPrimaryFillActive.cgColor
        
        [selectedImageView, checkboxView, titleTextLabel].forEach(addSubview(_:))
        
        checkboxView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.left.top.bottom.equalToSuperview()
        }
        selectedImageView.snp.makeConstraints {
            $0.center.equalTo(checkboxView)
        }
        titleTextLabel.snp.makeConstraints {
            $0.left.equalTo(checkboxView.snp.right).offset(LayoutGuidance.offset)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(checkboxView)
        }
    }
    
    private func updateCheckboxConstraintsIfNeeded() {
        let size = titleTextLabel.systemLayoutSizeFitting(
            CGSize(
                width: self.frame.width - 30 - LayoutGuidance.offset,
                height: UIView.layoutFittingCompressedSize.height))
        if size.height > 32 {
            checkboxView.snp.remakeConstraints {
                $0.left.equalToSuperview()
                $0.size.equalTo(32)
            }
            titleTextLabel.snp.remakeConstraints {
                $0.left.equalTo(checkboxView.snp.right).offset(LayoutGuidance.offset)
                $0.right.equalToSuperview()
                $0.centerY.equalTo(checkboxView)
                $0.top.bottom.equalToSuperview()
            }
        }
    }
    
    @objc private func didTapCheckbox() {
        isChecked = !isChecked
        checkBoxTap?(isChecked)
    }
    
    @objc private func didTapText() {
        textTap?()
    }
}
