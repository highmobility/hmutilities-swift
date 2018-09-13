//
// HMUtilities
// Copyright (C) 2018 High-Mobility GmbH
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
//  FixedWidthInteger+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension FixedWidthInteger {

    /// Converts the value to the number of bytes used to represent the value.
    ///
    /// *E.g.* UInt32 would return 4 bytes, Int64 would return 8 bytes.
    var bytes: [UInt8] {
        return Swift.stride(from: 0, to: bitWidth, by: 8).reversed().map { UInt8((self >> $0) & 0xFF) }
    }


    /// Initialise the integer with bytes.
    ///
    /// *E.g.* UInt32 would be initialised with *4 bytes*, UInt64 with *8 bytes*, etc...
    init<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        let bytesCount = Self(1).bitWidth / 8   // Workaround for self.bitWidth
        let prefixedBytes = binary.bytes.prefix(bytesCount)

        self = prefixedBytes.reduce(Self(0)) { ($0 << 8) + Self($1) }
    }
}
