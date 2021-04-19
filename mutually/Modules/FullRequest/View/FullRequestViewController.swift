//
//  FullRequestViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class FullRequestViewController: BaseViewController, FullRequestViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: FullRequestViewOutput?
    
    private lazy var collectionViewManager = PhotoCollectionViewManager(collectionView: collectionView)

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let stackView = ScrollableStackView()
    
    private let titleLabel = LabelFactory().make(withStyle: .paragraphBody,
                                                 textColor: Color.textHighContrast)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = .init(width: view.frame.width, height: 40)
        layout.minimumInteritemSpacing = LayoutGuidance.offsetQuarter
        layout.minimumLineSpacing = LayoutGuidance.offset
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(
            width: 70, height: 100)
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(
            top: 0, left: LayoutGuidance.offsetSuperLarge, bottom: LayoutGuidance.buttonHeight, right: LayoutGuidance.offsetSuperLarge)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    private let button = Button.makePrimary(with: "Отправить фотографий")

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - FullRequestViewInput
    // ------------------------------

    func display(viewAdapter: FullRequestViewAdapter) {
        titleLabel.text = viewAdapter.title
        collectionViewManager.display(sections: viewAdapter.sections)
        collectionView.reloadData()
    }
    
    func button(isLoading: Bool, text: String?) {
        button.isLoading = isLoading
        guard let text = text else { return }
        button.set(title: text)
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        title = "Заявка"
        stackView.backgroundColor = .gray
        
        button.touchUpInside = { [weak self] in
            self?.output?.buttonDidTap()
        }

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
//        stackView.add(subview: collectionView)
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(button)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(LayoutGuidance.offset)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(LayoutGuidance.offsetThreeQuarters)
            $0.width.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview().inset(LayoutGuidance.offsetSuperLarge)
        }
    }
}
