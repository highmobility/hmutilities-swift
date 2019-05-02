//
// HMUtilitiesTests
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
//  HMBytesConvertableTests.swift
//  HMUtilitiesTests
//
//  Created by Mikk Rätsep on 05/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import HMUtilities
import XCTest


class HMBytesConvertableTests: XCTestCase {

    static var allTests = [("testProtocolExtension", testProtocolExtension),
                           ("testIntegers", testIntegers),
                           ("testRawRepresentable", testRawRepresentable)]


    // MARK: XCTestCase

    func testProtocolExtension() {
        XCTAssertNotNil(Int(bytes: Optional<[UInt8]>([0x00, 0x11])))
        XCTAssertNotNil(Int(bytes: ([0x00, 0x11, 0x22].prefix(2))))
        XCTAssertNil(Int(bytes: Optional<[UInt8]>.none))
        XCTAssertNil(Int(bytes: Optional<ArraySlice<UInt8>>.none))
    }

    func testIntegers() {
        // Bytes
        XCTAssertEqual(Int8(-11).bytes, [0xF5])
        XCTAssertEqual(Int16(-9876).bytes, [0xD9, 0x6C])
        XCTAssertEqual(Int32(-123456789).bytes, [0xF8, 0xA4, 0x32, 0xEB])
        XCTAssertEqual(Int64(-123456789).bytes, [0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xA4, 0x32, 0xEB])
        XCTAssertEqual(UInt8(11).bytes, [0x0B])
        XCTAssertEqual(UInt16(9876).bytes, [0x26, 0x94])
        XCTAssertEqual(UInt32(123456789).bytes, [0x07, 0x5B, 0xCD, 0x15])
        XCTAssertEqual(UInt64(123456789).bytes, [0x00, 0x00, 0x00, 0x00, 0x07, 0x5B, 0xCD, 0x15])

        // Init
        XCTAssertEqual(Int8(bytes: [0xF5]), -11)
        XCTAssertEqual(Int16(bytes: [0xD9, 0x6C]), -9876)
        XCTAssertEqual(Int32(bytes: [0xF8, 0xA4, 0x32, 0xEB]), -123456789)
        XCTAssertEqual(Int64(bytes: [0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xA4, 0x32, 0xEB]), -123456789)
        XCTAssertEqual(UInt8(bytes: [0x0B]), 11)
        XCTAssertEqual(UInt16(bytes: [0x26, 0x94]), 9876)
        XCTAssertEqual(UInt32(bytes: [0x07, 0x5B, 0xCD, 0x15]), 123456789)
        XCTAssertEqual(UInt64(bytes: [0x00, 0x00, 0x00, 0x00, 0x07, 0x5B, 0xCD, 0x15]), 123456789)

        // Init Fails
        XCTAssertNil(Int8(bytes: [0xF5, 0x00]))
        XCTAssertNil(Int16(bytes: [0xD9, 0x6C, 0x00]))
        XCTAssertNil(Int32(bytes: [0xF8, 0xA4, 0x32]))
        XCTAssertNil(Int64(bytes: [0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xA4, 0x32]))
        XCTAssertNil(UInt8(bytes: [0x0B, 0x00]))
        XCTAssertNil(UInt16(bytes: [0x26, 0x94, 0x00]))
        XCTAssertNil(UInt32(bytes: [0x07, 0x5B, 0xCD]))
        XCTAssertNil(UInt64(bytes: [0x00, 0x00, 0x00, 0x00, 0x07, 0x5B, 0xCD]))
    }

    func testRawRepresentable() {
        enum Test: UInt8, HMBytesConvertable {
            case zero   = 0x00
            case more   = 0xAF
        }

        // Bytes
        XCTAssertEqual(Test.zero.bytes, [0x00])
        XCTAssertEqual(Test.more.bytes, [0xAF])

        // Init
        XCTAssertEqual(Test(bytes: [0x00]), .zero)
        XCTAssertEqual(Test(bytes: [0xAF]), .more)
        XCTAssertNil(Test(bytes: [0x02]))
    }
}
