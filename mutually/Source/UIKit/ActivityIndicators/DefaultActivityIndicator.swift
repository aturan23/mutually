//
//  DefaultActivityIndicator.swift
//  mutually
//
//  Created by Turan Assylkhan on 03.04.2021.
//

import UIKit

extension UIActivityIndicatorView {
    static func makeDefault(
        style: UIActivityIndicatorView.Style = .gray
    ) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }
}
