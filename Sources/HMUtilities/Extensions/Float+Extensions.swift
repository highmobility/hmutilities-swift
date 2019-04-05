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
//  Float+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


extension Float: HMBytesConvertable {

    /// The bit pattern of the float, using the *IEE 754* standard.
    public var bytes: [UInt8] {
        return bitPattern.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 4,
            let uint32 = UInt32(bytes: bytes) else {
                return nil
        }

        self = Float(bitPattern: uint32)
    }
}
