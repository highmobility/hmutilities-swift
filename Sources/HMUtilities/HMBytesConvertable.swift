//
// HMUtilities
// Copyright (C) 2019 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  HMBytesConvertable.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 12/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public protocol HMBytesConvertable {

    var bytes: [UInt8] { get }


    init?(bytes: [UInt8])
}

extension HMBytesConvertable {

    public init?(bytes: Array<UInt8>?) {
        guard let bytes = bytes else {
            return nil
        }

        self.init(bytes: bytes)
    }

    public init?(bytes: ArraySlice<UInt8>?) {
        guard let bytes = bytes else {
            return nil
        }

        self.init(bytes: Array(bytes))
    }
}

extension HMBytesConvertable where Self: FixedWidthInteger {

    /// Converts the value to the number of bytes used to represent the value.
    ///
    /// *E.g.* UInt32 would return 4 bytes, Int64 would return 8 bytes.
    public var bytes: [UInt8] {
        return Swift.stride(from: 0, to: bitWidth, by: 8).reversed().map { UInt8((self >> $0) & 0xFF) }
    }

    /// Initialise the integer with bytes.
    ///
    /// *E.g.* `UInt32` would be initialised with *4 bytes*, `UInt64` with *8 bytes*, etc...
    public init?(bytes: [UInt8]) {
        // Workaround for self.bitWidth
        let bytesCount = Self(1).bitWidth / 8

        guard bytes.count == bytesCount else {
            return nil
        }

        self = bytes.prefix(bytesCount).reduce(Self(0)) { ($0 << 8) + Self($1) }
    }
}

extension HMBytesConvertable where Self: RawRepresentable, Self.RawValue == UInt8 {

    public var bytes: [UInt8] {
        return [rawValue]
    }


    public init?(bytes: [UInt8]) {
        guard let uint8 = UInt8(bytes: bytes),
            let value = Self(rawValue: uint8) else {
                return nil
        }

        self = value
    }
}


// Signed ints
extension Int: HMBytesConvertable {

    public init?(bytes: [UInt8]) {
        let bytesCount = Int(1).bitWidth / 8   // Workaround for self.bitWidth
        let prefixedBytes = bytes.prefix(bytesCount)

        self = prefixedBytes.reduce(Int(0)) { ($0 << 8) + Int($1) }
    }
}

extension Int8: HMBytesConvertable {

    public var bytes: [UInt8] {
        return [UInt8(bitPattern: self)]
    }


    public init?(bytes: [UInt8]) {
        guard let uint8 = UInt8(bytes: bytes) else {
            return nil
        }

        self = Int8(bitPattern: uint8)
    }
}

extension Int16: HMBytesConvertable {

    public init?(bytes: [UInt8]) {
        guard let uint16 = UInt16(bytes: bytes) else {
            return nil
        }

        self = Int16(bitPattern: uint16)
    }
}

extension Int32: HMBytesConvertable {

    public init?(bytes: [UInt8]) {
        guard let uint32 = UInt32(bytes: bytes) else {
            return nil
        }

        self = Int32(bitPattern: uint32)
    }
}

extension Int64: HMBytesConvertable {

    public init?(bytes: [UInt8]) {
        guard let uint64 = UInt64(bytes: bytes) else {
            return nil
        }

        self = Int64(bitPattern: uint64)
    }
}


// Unsigned ints
extension UInt: HMBytesConvertable {

}

extension UInt8: HMBytesConvertable {

}

extension UInt16: HMBytesConvertable {

}

extension UInt32: HMBytesConvertable {

}

extension UInt64: HMBytesConvertable {

}
