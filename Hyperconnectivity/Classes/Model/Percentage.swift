//
//  Percentage.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 07/05/2020.
//

import Foundation

public struct Percentage: Comparable {
    let value: Double

    public init(_ value: Double) {
        var result = value < 0.0 ? 0.0 : value
        result = value > 100.0 ? 100.0 : value
        self.value = result
    }
    
    public init(_ value: UInt, outOf total: UInt) {
        self.init(Double(value), outOf: Double(total))
    }
    
    public init(_ value: Double, outOf total: Double) {
        self.init((value / total) * 100.0)
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
}
