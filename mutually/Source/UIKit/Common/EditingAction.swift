//
//  EditingAction.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

enum EditingAction {
    case copy
    case paste
    
    var selectorId: String {
        switch self {
        case .copy:
            return "copy:"
        case .paste:
            return "paste:"
        }
    }
}
