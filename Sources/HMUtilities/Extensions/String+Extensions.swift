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
//  String+Extensions.swift
//  HMCryptoKitCLT
//
//  Created by Mikk Rätsep on 07/03/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public extension String {

    // Bytes from an *hex* string
    var hexBytes: [UInt8] {
        return characterPairs.compactMap { UInt8($0, radix: 16) }
    }
}

extension String: HMBytesConvertable {

    public var bytes: [UInt8] {
        return data(using: .utf8)?.bytes ?? []
    }


    public init?(bytes: [UInt8]) {
        self.init(data: bytes.data, encoding: .utf8)
    }
}

extension String {

    var characterPairs: [String] {
        let cleanString = replacingOccurrences(of: "0x", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ", with: "")

        return cleanString.enumerated().reduce([String]()) { (midResult, enumerationTuple) in
            var result = midResult

            if (enumerationTuple.offset % 2) == 1 {
                result[result.endIndex - 1] = midResult.last! + enumerationTuple.element.description
            }
            else {
                result.append(enumerationTuple.element.description)
            }

            return result
        }
    }
}
