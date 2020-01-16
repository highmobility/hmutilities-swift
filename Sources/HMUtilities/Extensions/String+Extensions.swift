//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  String+Extensions.swift
//  HMCryptoKitCLT
//
//  Created by Mikk Rätsep on 07/03/2018.
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
        guard let data = data(using: .utf8) else {
            return []
        }

        return Array(data)
    }


    public init?(bytes: [UInt8]) {
        self.init(data: Data(bytes), encoding: .utf8)
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
