//
//  RectangleMask.swift
//  mutually
//
//  Created by Turan Assylkhan on 17.04.2021.
//

import UIKit

class RectangleMask: UIView {
    
    private let borderLineView = UIView()
    private let lineView = UIView()
    
    init(line: Bool = true) {
        super.init(frame: .zero)
        lineView.isHidden = !line
        borderLineView.isHidden = line
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(borderLineView)
        addSubview(lineView)
        
        borderLineView.layer.borderWidth = 1
        borderLineView.layer.borderColor = UIColor.white.cgColor
        borderLineView.layer.cornerRadius = 4
        
        lineView.backgroundColor = .white
        
        borderLineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(LayoutGuidance.offsetLarge)
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offsetLarge)
        }
        
        lineView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
            $0.centerY.equalToSuperview()
        }
    }
}
