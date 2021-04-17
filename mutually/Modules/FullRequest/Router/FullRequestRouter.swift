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

	// ------------------------------
    // MARK: - FullRequestRouterInput
    // ------------------------------
    
    func routeToCamera(delegate: ImagePickerDelegate?, mask: MaskType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = delegate
        imagePickerController.sourceType = .camera
        imagePickerController.cameraDevice = mask == .selfieWithPassport ? .front : .rear
        
        let screenSize = UIScreen.main.bounds.size
        let cameraAspectRatio: CGFloat = 4.0 / 3.0
        let imageHeight = screenSize.width * cameraAspectRatio
        var verticalAdjustment: CGFloat
        verticalAdjustment = (screenSize.height - imageHeight) / 2.0
        verticalAdjustment /= 1.425
        var transform = imagePickerController.cameraViewTransform
        transform.ty = verticalAdjustment
        let previewFrame = CGRect(x: 0, y: verticalAdjustment, width: screenSize.width, height: imageHeight)
        let overlayView = UIView(frame: previewFrame)

        let maskedView = maskView(by: mask)
        overlayView.addSubview(maskedView)
        maskedView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        imagePickerController.cameraOverlayView = overlayView
        
        viewController?.present(imagePickerController, animated: true)
    }
    
    private func maskView(by type: MaskType) -> UIView {
        switch type {
        case .autoPassportFront, .autoPassportBack:
            return PassportFrontMask(showPhotoLine: type == .autoPassportFront)
        case .rectangle, .divided:
            return RectangleMask(line: type == .divided)
        default:
            return UIView()
        }
    }
}
