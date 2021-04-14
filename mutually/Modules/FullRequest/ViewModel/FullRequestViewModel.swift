//
//  FullRequestViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class FullRequestViewModel: FullRequestViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: FullRequestViewInput?
    var router: FullRequestRouterInput?
    weak var moduleOutput: FullRequestModuleOutput?
    private var photos: [Photo] = []

    // ------------------------------
    // MARK: - FullRequestViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: buildAdapter())
    }
    
    private func buildAdapter() -> FullRequestViewAdapter {
        let documents = FullRequestCollectionAdapter(title: PhotoGroup.documents.title,
                                                     items: photos.filter { $0.group == .documents },
                                                     onSelection: didSelectAt(_:))
        let auto = FullRequestCollectionAdapter(title: PhotoGroup.auto.title,
                                                items: photos.filter { $0.group == .auto },
                                                onSelection: didSelectAt(_:))
        let others = FullRequestCollectionAdapter(title: PhotoGroup.other.title,
                                                  items: photos.filter { $0.group == .other },
                                                  onSelection: didSelectAt(_:))
        
        return .init(sections: [documents, auto, others])
    }
    
    private func didSelectAt(_ indexPath: IndexPath) {
        
    }
}

// ------------------------------
// MARK: - FullRequestModuleInput methods
// ------------------------------

extension FullRequestViewModel: FullRequestModuleInput {
    func configure(data: FullRequestConfigData) {
        guard let photos = data.photos else { return }
        self.photos = photos
    }
}
