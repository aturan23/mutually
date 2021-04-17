//
//  SelfieMask.swift
//  mutually
//
//  Created by Turan Assylkhan on 17.04.2021.
//

import UIKit

class SelfieMask: UIView {
    
    private let rectangle = UIView()
    private let circle = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [rectangle, circle].forEach(addSubview(_:))
        
        rectangle.layer.borderWidth = 1
        rectangle.layer.borderColor = UIColor.white.cgColor
        rectangle.layer.cornerRadius = 4
        
        circle.layer.borderWidth = 1
        circle.layer.borderColor = UIColor.white.cgColor
        circle.layer.cornerRadius = 80
        
        rectangle.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 180, height: 280))
            $0.left.equalTo(LayoutGuidance.offsetThreeQuarters)
            $0.bottom.equalTo(-50)
        }
        
        circle.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 150, height: 200))
            $0.centerY.equalToSuperview().offset(-50)
            $0.right.equalTo(-LayoutGuidance.offsetHalf)
        }
    }
}
