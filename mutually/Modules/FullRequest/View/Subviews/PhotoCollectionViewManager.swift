//
//  PhotoCollectionViewManager.swift
//  mutually
//
//  Created by Turan Assylkhan on 08.04.2021.
//

import UIKit

class PhotoCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var rows: [Photo] = []
    private weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self)
        collectionView.register(CollectionSectionHeader.self)
    }
    
    func display(rows: [Photo]) {
        self.rows = rows
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header: CollectionSectionHeader = collectionView.dequeReusableHeaderView(for: indexPath)
            header.label.text = "Документы"
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeReusableCell(for: indexPath)
        cell.update(with: rows[indexPath.row])
        return cell
    }
}
