//
//  UInt8Collection+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension Collection where Element == UInt8 {

    /// The combined *hex* string representation of the values in the collection.
    var hex: String {
        return map { String(format: "%02X", $0) }.joined()
    }

    /// The simple Array(self) accessor.
    var bytes: [UInt8] {
        return Array(self)
    }

    /// Date accessor.
    var data: Data {
        return Data(bytes: bytes)
    }
}
