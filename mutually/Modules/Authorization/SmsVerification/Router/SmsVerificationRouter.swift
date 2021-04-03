//
//  SmsVerificationRouter.swift
//  mutually
//
//  Created by Turan Assylkhan on 03/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

class SmsVerificationRouter: SmsVerificationRouterInput {
    
	weak var viewController: UIViewController?
    let alertFactory = AlertFactory()

	// ------------------------------
    // MARK: - SmsVerificationRouterInput
    // ------------------------------
    
    func routeBack(completion: (() -> Void)?) {
        viewController?.dismiss(animated: true, completion: completion)
    }
}
