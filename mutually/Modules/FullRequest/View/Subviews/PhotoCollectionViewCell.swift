//
//  PhotoCollectionViewCell.swift
//  mutually
//
//  Created by Turan Assylkhan on 08.04.2021.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let containerSize: CGFloat = 70
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private let iconImageView = UIImageView(image: Asset.iconEmptyImg.image)
    private let titleLabel = LabelFactory().make(
        withStyle: .paragraph,
        textColor: Color.textLowContrast)
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ------------------------------
    // MARK: - Public methods
    // ------------------------------
    
    func update(with viewAdapter: Photo) {
        if let path = viewAdapter.pathUrl {
            iconImageView.setImage(with: path)
        } else {
            iconImageView.image = Asset.iconEmptyImg.image
        }
        titleLabel.text = viewAdapter.title
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func setupViews() {
        containerView.backgroundColor = .white
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 8
        
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit
        
        setupViewsHierarchy()
        setupConstraints()
    }
    private func setupViewsHierarchy() {
        containerView.addSubview(iconImageView)
        [containerView, titleLabel].forEach(contentView.addSubview(_:))
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.size.equalTo(Constants.containerSize)
            $0.top.left.right.equalToSuperview()
        }
        iconImageView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(LayoutGuidance.offsetHalf)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(-LayoutGuidance.offsetQuarter)
        }
    }
}
