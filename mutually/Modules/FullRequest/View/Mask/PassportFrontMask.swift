//
//  PassportFrontMask.swift
//  mutually
//
//  Created by Turan Assylkhan on 17.04.2021.
//

import UIKit

class PassportFrontMask: UIView {
    
    private let borderLineView = UIView()
    private let photoLineView = UIView()
    
    init(showPhotoLine: Bool = true) {
        super.init(frame: .zero)
        photoLineView.isHidden = !showPhotoLine
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(borderLineView)
        borderLineView.addSubview(photoLineView)
        
        borderLineView.layer.borderWidth = 1
        borderLineView.layer.borderColor = UIColor.white.cgColor
        borderLineView.layer.cornerRadius = 4
        
        photoLineView.layer.borderWidth = 1
        photoLineView.layer.borderColor = UIColor.white.cgColor
        photoLineView.layer.cornerRadius = 4
        
        borderLineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(LayoutGuidance.offsetLarge)
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge * 1.25)
        }
        
        photoLineView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge * 2)
            $0.height.equalTo(150)
            $0.bottom.equalTo(-LayoutGuidance.offsetSuperLarge * 1.5)
        }
    }
}
