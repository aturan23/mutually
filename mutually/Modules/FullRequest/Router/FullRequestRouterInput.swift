//
//  FullRequestRouterInput.swift
//  mutually
//
//  Created by Turan Assylkhan on 08/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

import UIKit

protocol FullRequestRouterInput: AlertShowingRouter {
    func routeToCamera(delegate: ImagePickerDelegate?, mask: MaskType)
}
