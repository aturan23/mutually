//
//  StringExtension.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

extension String {
    /// Substring method
    ///
    /// - Parameters:
    ///   - lower: lower bound
    ///   - upper: upper bound (exclusive)
    /// - Returns: substring value
    func substr(_ lower: Int, _ upper: Int? = nil) -> String {
        // guard against negative lower bound
        var low = max(0, lower)
        // guard against lower bound overflown
        low = min(count, low)
        // guard against nil or overflown upper bound
        var up = min(count, upper ?? count)
        // guard against upper < lower case
        up = max(up, low)
        
        return self[Range(uncheckedBounds: (low, up))]
    }
    
    var onlyDigits: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    
    var isPhoneNumber: Bool {
        return matches(regex: "^((8|\\+7|7)[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{10,10}$")
    }
    
    func matches(regex: String) -> Bool {
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

// MARK: - Subscripts

extension String {
    subscript (range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[Range(uncheckedBounds: (lower: start, upper: end))])
    }
}
