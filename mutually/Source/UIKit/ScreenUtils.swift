//
//  ScreenUtils.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

class ScreenUtils {
    static func isiPhone5AndLowerDeviceScreen(_ screen: UIScreen) -> Bool {
        return screen.bounds.width <= 320 && screen.bounds.height <= 568
    }
}
