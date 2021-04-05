//
//  DefaultNavigationController.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

extension UINavigationController {
    static func makeDefault(root: UIViewController? = nil) -> UINavigationController {
        var navigationController: UINavigationController
        if let controller = root {
            navigationController = UINavigationController(rootViewController: controller)
        } else {
            navigationController = UINavigationController()
        }
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        var largeTitleTextAttributes = LabelFactory.makeAttributes(for: .headingH2)
        if ScreenUtils.isiPhone5AndLowerDeviceScreen(UIScreen.main) {
            largeTitleTextAttributes[.font] = UIFont.bold(size: 30)
        } else {
            largeTitleTextAttributes[.font] = UIFont.bold(size: 34)
        }
        navigationController.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        return navigationController
    }
}
