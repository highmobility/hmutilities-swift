//
//  Bool+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension Bool {

    var byte: UInt8 {
        return self ? 0x01 : 0x00
    }
}
