//
//  UIImageViewExtension.swift
//  mutually
//
//  Created by Turan Assylkhan on 17.04.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL, backupUrl: URL? = nil) {
        kf.indicatorType = .activity
        kf.setImage(with: ImageResource(downloadURL: url), completionHandler:  { [weak self] result in
            switch result {
            case .success:
                break
            case .failure:
                if let backupUrl = backupUrl {
                    self?.kf.setImage(with: backupUrl)
                }
            }
        })
    }
}
