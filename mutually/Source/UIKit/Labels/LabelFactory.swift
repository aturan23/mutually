//
//  LabelFactory.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

final class LabelFactory {
    /**
     Instead of setting a attributedText empty or nil, use this one to keep attributes.
     */
    static var emptyText: String = " "
    
    static func makeAttributes(
        for style: TextStyle,
        textAlignment: NSTextAlignment? = nil
    ) -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = style.lineSpacing
        if let textAlignment = textAlignment {
            paragraphStyle.alignment = textAlignment
        }
        paragraphStyle.lineBreakMode = .byTruncatingTail
        return [.font: style.font,
                .kern : style.kern,
                .paragraphStyle : paragraphStyle]
    }
    
    
    func make(withStyle style: TextStyle,
              text: String = "",
              textColor: UIColor = Color.textHighContrast,
              textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.attributedText = NSAttributedString(
            string: text.isEmpty ? LabelFactory.emptyText: text,
            attributes: LabelFactory.makeAttributes(
                for: style,
                textAlignment: textAlignment)
        )
        return label
    }
    
    func make(for text: NSAttributedString,
              textColor: UIColor = Color.textHighContrast,
              textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.attributedText = text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        label.setAttribute(key: .paragraphStyle, value: paragraphStyle)
        return label
    }
    
    func makeCardWidgetLabel(with font: UIFont) -> UILabel {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        label.attributedText = NSAttributedString(
            string: " ",
            attributes: [.font: font,
                         .foregroundColor: Color.textHighContrast,
                         .kern: 0.3,
                         .paragraphStyle: paragraphStyle]
        )
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
    
    func makeCarouselWidgetCellLabel() -> UILabel {
        let textStyle = TextStyle.paragraphCaption
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        label.attributedText = NSAttributedString(
            string: " ",
            attributes: [.font: textStyle.font,
                         .foregroundColor: Color.textHighContrast,
                         .kern: textStyle.kern,
                         .paragraphStyle: paragraphStyle]
        )
        return label
    }
}
