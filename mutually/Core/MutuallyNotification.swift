//
//  MutuallyNotification.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

enum MutuallyNotification: String {
    case sessionDidTimeout
    case networkFailed
    
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
}
