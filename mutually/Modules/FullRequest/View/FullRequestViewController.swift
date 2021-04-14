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
            top: 0, left: LayoutGuidance.offsetSuperLarge, bottom: 0, right: LayoutGuidance.offsetSuperLarge)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        return collectionView
    }()

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
        collectionViewManager.display(rows: Array(repeating: Photo(title: "Title"), count: 13))
        collectionView.reloadData()
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        title = "Заявка"
        stackView.backgroundColor = .gray

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
//        stackView.add(subview: collectionView)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
