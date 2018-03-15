//
//  Float+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension Float {

    var bytes: [UInt8] {
        return bitPattern.bytes
    }
}
