//
//  CheckBoxView.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

class CheckBoxView: UIView, UITextViewDelegate {
    
    var checkBoxTap: ((Bool) -> Void)?
    
    var isChecked: Bool = false {
        didSet {
            selectedImageView.isHidden = !isChecked
        }
    }
    var title: String? {
        get { return titleTextView.text }
        set {
            titleTextView.text = newValue
            updateCheckboxConstraintsIfNeeded()
        }
    }
    var attributedTitle: NSAttributedString? {
        get { return titleTextView.attributedText }
        set {
            titleTextView.attributedText = newValue
            updateCheckboxConstraintsIfNeeded()
        }
    }
    
    private var titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        textView.textColor = UIColor.black
        textView.isEditable = false
        textView.isSelectable = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return textView
    }()
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkboxView.addGestureRecognizer(gesture)
        titleTextView.delegate = self
        
        selectedImageView.isHidden = !isChecked
        
        checkboxView.layer.cornerRadius = 8
        checkboxView.layer.borderWidth = 1
        checkboxView.layer.borderColor = Color.buttonPrimaryFillActive.cgColor
        
        [selectedImageView, checkboxView, titleTextView].forEach(addSubview(_:))
        
        checkboxView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.left.top.bottom.equalToSuperview()
        }
        selectedImageView.snp.makeConstraints {
            $0.center.equalTo(checkboxView)
        }
        titleTextView.snp.makeConstraints {
            $0.left.equalTo(checkboxView.snp.right).offset(LayoutGuidance.offset)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(checkboxView)
        }
    }
    
    private func updateCheckboxConstraintsIfNeeded() {
        let size = titleTextView.systemLayoutSizeFitting(
            CGSize(
                width: self.frame.width - 30 - LayoutGuidance.offset,
                height: UIView.layoutFittingCompressedSize.height))
        if size.height > 32 {
            checkboxView.snp.remakeConstraints {
                $0.left.equalToSuperview()
                $0.size.equalTo(32)
            }
            titleTextView.snp.remakeConstraints {
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
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
