//
//  FixedWidthInteger+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension FixedWidthInteger {

    var bytes: [UInt8] {
        return Swift.stride(from: 0, to: bitWidth, by: 8).reversed().map { UInt8((self >> $0) & 0xFF) }
    }
}
