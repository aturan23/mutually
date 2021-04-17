//
//  FullRequestViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class FullRequestViewModel: NSObject, FullRequestViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: FullRequestViewInput?
    var router: FullRequestRouterInput?
    weak var moduleOutput: FullRequestModuleOutput?
    var imageService: ImageServiceProtocol?
    
    private var indexPath = IndexPath(index: 0)
    private var photos: [Photo] = []
    private var title: String? = nil
    private var sections: [FullRequestCollectionAdapter] = [] {
        didSet {
            view?.display(viewAdapter: .init(sections: sections, title: title))
        }
    }

    // ------------------------------
    // MARK: - FullRequestViewOutput methods
    // ------------------------------

    func didLoad() {
        sections = configureSections()
    }
    
    func buttonDidTap() {
        imageService?.done(completion: { [weak self] (result) in
            switch result {
            case .success:
                print("")
            case .failure(let error):
                self?.router?.showAlert(message: error.message)
            }
        })
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func didSelectAt(_ indexPath: IndexPath) {
        self.indexPath = indexPath
        let photo = sections[indexPath.section].items[indexPath.row]
        router?.routeToCamera(delegate: self, mask: photo.maskType)
    }
    
    private func configureSections() -> [FullRequestCollectionAdapter] {
        let documents = FullRequestCollectionAdapter(title: PhotoGroup.documents.title,
                                                     items: photos.filter { $0.group == .documents },
                                                     onSelection: didSelectAt(_:))
        let auto = FullRequestCollectionAdapter(title: PhotoGroup.auto.title,
                                                items: photos.filter { $0.group == .auto },
                                                onSelection: didSelectAt(_:))
        let others = FullRequestCollectionAdapter(title: PhotoGroup.other.title,
                                                  items: photos.filter { $0.group == .other },
                                                  onSelection: didSelectAt(_:))
        return [documents, auto, others]
    }
    
    private func save(data: Data) {
        imageService?.upload(data: data, type: "3", completion: { [weak self] (result) in
            switch result {
            case .success:
                self?.view?.displayButton()
            case .failure(let error):
                self?.router?.showAlert(message: error.message)
            }
        })
    }
}

// ------------------------------
// MARK: - FullRequestModuleInput methods
// ------------------------------

extension FullRequestViewModel: FullRequestModuleInput {
    func configure(data: FullRequestConfigData) {
        guard let photos = data.photos else { return }
        self.photos = photos
        title = data.title
    }
}

extension FullRequestViewModel: ImagePickerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage,
           let png = img.pngData() {
            save(data: png)
            picker.dismiss(animated: true)
        }
    }
}
