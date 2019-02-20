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

    public init?<C>(bytes: C?) where C: Collection, C.Element == UInt8 {
        guard let bytes = bytes?.bytes else {
            return nil
        }

        self.init(bytes: bytes)
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
        let bytesCount = Self(1).bitWidth / 8   // Workaround for self.bitWidth
        let prefixedBytes = bytes.prefix(bytesCount)

        self = prefixedBytes.reduce(Self(0)) { ($0 << 8) + Self($1) }
    }
}

extension HMBytesConvertable where Self: RawRepresentable, Self.RawValue == UInt8 {

    public var bytes: [UInt8] {
        return [rawValue]
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 1 else {
            return nil
        }

        guard let value = Self(rawValue: bytes[0]) else {
            return nil
        }

        self = value
    }
}


// Just helps...
extension Int: HMBytesConvertable {

}

extension Int8: HMBytesConvertable {

}

extension Int16: HMBytesConvertable {

}

extension Int32: HMBytesConvertable {

}

extension Int64: HMBytesConvertable {

}

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
