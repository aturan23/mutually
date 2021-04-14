//
//  PhotoCollectionViewManager.swift
//  mutually
//
//  Created by Turan Assylkhan on 08.04.2021.
//

import UIKit

class PhotoCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var sections: [FullRequestCollectionAdapter] = []
    private weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self)
        collectionView.register(CollectionSectionHeader.self)
    }
    
    func display(sections: [FullRequestCollectionAdapter]) {
        self.sections = sections
    }
    
    // UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header: CollectionSectionHeader = collectionView.dequeReusableHeaderView(for: indexPath)
            header.label.text = sections[indexPath.section].title
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeReusableCell(for: indexPath)
        cell.update(with: sections[indexPath.section].items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        sections[indexPath.section].onSelection?(indexPath)
    }
}
