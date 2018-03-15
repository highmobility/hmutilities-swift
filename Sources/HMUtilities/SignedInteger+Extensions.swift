//
//  SignedInteger+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension SignedInteger {

    var uint8: UInt8 {
        return UInt8(truncatingIfNeeded: self)
    }
}
