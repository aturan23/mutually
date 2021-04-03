//
//  SmsCharView.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

final class SmsCharView: UIView {
    enum Constant {
        
    }
    
    var attributedText: NSAttributedString? {
        didSet {
            label.attributedText = attributedText
        }
    }
    var lineColor: UIColor? = Color.textLowContrast {
        didSet {
            lineView.backgroundColor = lineColor
        }
    }
    var font: UIFont! {
        didSet {
            label.font = font
        }
    }
    var text: String? {
        get { label.text }
        set { }
    }
    
    // MARK: - UI components
    
    private let label = UILabel()
    private let lineView = UIView()
    
    // MARK: - Properties
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        label.textAlignment = .center
        lineView.backgroundColor = lineColor
        
        [label, lineView].forEach(addSubview(_:))
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(50)
            $0.left.right.equalToSuperview()
        }
        lineView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(LayoutGuidance.offset)
            $0.height.equalTo(1.5)
            $0.width.equalTo(label)
            $0.bottom.equalToSuperview()
        }
    }
    
    
}
