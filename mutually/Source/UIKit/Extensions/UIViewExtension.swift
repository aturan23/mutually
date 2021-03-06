//
//  UIViewExtension.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

extension UIView {
    struct ValuesHolder {
        static var tapClosures: [UIView: () -> Void] = [:]
        static var backgroundColors: [UIView: UIColor] = [:]
    }
    var originalBackgroundColor: UIColor? {
        get {
            return ValuesHolder.backgroundColors[self] ?? backgroundColor
        }
        set(value) {
            ValuesHolder.backgroundColors[self] = value
        }
    }
    var closure: (() -> Void) {
        get {
            return ValuesHolder.tapClosures[self] ?? {}
        }
        set(value) {
            ValuesHolder.tapClosures[self] = value
        }
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func dropShadow(shadowColor: UIColor = Asset.cardShadow.color,
                    fillColor: UIColor = UIColor.white,
                    opacity: Float = 1,
                    offset: CGSize = CGSize(width: 0, height: 4),
                    radius: CGFloat = 12,
                    shadowRadius: CGFloat = 10,
                    corners: UIRectCorner = []) {
        if let sublayer = layer.sublayers?.first(where: { $0.name == "DropShadow" }) {
            sublayer.removeFromSuperlayer()
        }
        let shadowLayer = CAShapeLayer()
        if corners.isEmpty {
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        } else {
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        }
        shadowLayer.name = "DropShadow"
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addTap(_ closure: @escaping (() -> Void)) {
        self.closure = closure
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        closure()
    }
}
