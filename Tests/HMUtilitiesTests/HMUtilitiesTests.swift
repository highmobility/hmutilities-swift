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

import HMUtilities
import XCTest


class HMUtilitiesTests: XCTestCase {

    static var allTests = [("testBool", testBool),
                           ("testFixedWidthInteger", testFixedWidthInteger),
                           ("testFloat", testFloat),
                           ("testSignedInteger", testSignedInteger),
                           ("testString", testString),
                           ("testUInt8Collection", testUInt8Collection)]


    // MARK: XCTestCase

    func testBool() {
        XCTAssertEqual(true.byte, 0x01)
        XCTAssertEqual(false.byte, 0x00)
    }

    func testFixedWidthInteger() {
        XCTAssertEqual(Int8(11).bytes, [0x0B])
        XCTAssertEqual(Int16(9876).bytes, [0x26, 0x94])
        XCTAssertEqual(Int32(123456789).bytes, [0x07, 0x5B, 0xCD, 0x15])
        XCTAssertEqual(Int64(123456789).bytes, [0x00, 0x00, 0x00, 0x00, 0x07, 0x5B, 0xCD, 0x15])
    }

    func testFloat() {
        XCTAssertEqual(Float(13.404954).bytes, [0x41, 0x56, 0x7A, 0xB1])
        XCTAssertEqual(Float(52.520008).bytes, [0x42, 0x52, 0x14, 0x7D])
    }

    func testSignedInteger() {
        XCTAssertEqual(1200.uint8, 0xB0)
        XCTAssertEqual((-654).uint8, (0xFF - 0x8E + 1))
    }

    func testString() {
        XCTAssertEqual("0011223344CCDDEEFF".bytes, [0x00, 0x11, 0x22, 0x33, 0x44, 0xCC, 0xDD, 0xEE, 0xFF])
        XCTAssertEqual("0123QW4567".bytes, [0x01, 0x23, 0x45, 0x67])
    }

    func testUInt8Collection() {
        let bytes: [UInt8] = [0x00, 0x01, 0x02, 0x03, 0x04, 0x0F]
        let data = Data(bytes: bytes)

        XCTAssertEqual(bytes.bytes, [0x00, 0x01, 0x02, 0x03, 0x04, 0x0F])
        XCTAssertEqual(bytes.data, Data(bytes: [0x00, 0x01, 0x02, 0x03, 0x04, 0x0F]))
        XCTAssertEqual(bytes.hex, "00010203040F")

        XCTAssertEqual(data.bytes, [0x00, 0x01, 0x02, 0x03, 0x04, 0x0F])
        XCTAssertEqual(data.data, Data(bytes: [0x00, 0x01, 0x02, 0x03, 0x04, 0x0F]))
        XCTAssertEqual(data.hex, "00010203040F")
    }
}
