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
//  HMBytesConvertable.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 12/02/2019.
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
