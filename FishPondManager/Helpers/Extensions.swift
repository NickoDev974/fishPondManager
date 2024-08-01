// Extensions.swift
// FishPondManager

import Foundation

extension String {
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.doubleValue
    }
}

extension Double {
    func roundedString(to places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
