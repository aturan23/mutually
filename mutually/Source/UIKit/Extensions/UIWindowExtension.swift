//
//  UIWindowExtension.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

extension UIWindow {
    var topMostViewController: UIViewController? {
        var controller = rootViewController
        while controller?.presentedViewController != nil {
            controller = controller?.presentedViewController
        }
        return controller
    }
}
