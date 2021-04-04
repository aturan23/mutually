//
//  StringUtils.swift
//  mutually
//
//  Created by Turan Assylkhan on 04.04.2021.
//

import Foundation

final class StringUtils {
    
    /// Check if all elements of string are equal.
    ///
    /// - Returns: True if all characters of the string are equal.
    static func allEqual(string: String) -> Bool {
        if let firstElement = string.first {
            return string.allSatisfy({ $0 == firstElement })
        }
        return true
    }
    
    /// Check if string consists of consecutive digits in
    /// increasing or decreasing order.
    static func isConsecutiveDigits(string: String) -> Bool {
        guard string.onlyDigits == string else {
            return false
        }
        let digits = string.onlyDigits.compactMap { Int(String($0)) }
        guard let firstElement = digits.first else {
            return false
        }
        var notIncreasing: Bool = false
        var notDecreasing: Bool = false
        for (index, digit) in digits.enumerated() {
            if digit - index != firstElement {
                notIncreasing = true
            }
            if digit + index != firstElement {
                notDecreasing = true
            }
        }
        return !notIncreasing || !notDecreasing
    }
}
