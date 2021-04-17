//
//  FullRequestRouter.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

typealias ImagePickerDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate

class FullRequestRouter: FullRequestRouterInput {
    var alertFactory = AlertFactory()
	weak var viewController: UIViewController?
    private var imagePickerController = UIImagePickerController()

	// ------------------------------
    // MARK: - FullRequestRouterInput
    // ------------------------------
    
    func routeToCamera(delegate: ImagePickerDelegate) {
        imagePickerController.delegate = delegate
        imagePickerController.sourceType = .camera
//        let view = UIView(frame: .init(x: 100, y: 100, width: 100, height: 100))
//        view.backgroundColor = .red
//        imagePickerController.cameraOverlayView = view
        viewController?.present(imagePickerController, animated: true)
    }
}
