//
//  CollectionSectionHeader.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

import UIKit

class CollectionSectionHeader: UICollectionReusableView {
    
    var label = LabelFactory().make(withStyle: .paragraphBody,
                                    textColor: Color.textHighContrast)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.left.right.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
