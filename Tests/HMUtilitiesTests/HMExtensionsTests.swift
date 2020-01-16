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
//  HMExtensionsTests.swift
//  HMUtilitiesTests
//
//  Created by Mikk Rätsep on 03/04/2019.
//

@testable import HMUtilities
import XCTest


class HMExtensionsTests: XCTestCase {

    static var allTests = [("testBool", testBool),
                           ("testCollection", testCollection),
                           ("testDate", testDate),
                           ("testDouble", testDouble),
                           ("testFloat", testFloat),
                           ("testSignedInteger", testSignedInteger),
                           ("testString", testString),
                           ("testURL", testURL)]


    // MARK: XCTestCase

    func testBool() {
        // Byte
        XCTAssertEqual(true.byte, 0x01)
        XCTAssertEqual(false.byte, 0x00)

        // Bytes
        XCTAssertEqual(true.bytes, [0x01])
        XCTAssertEqual(false.bytes, [0x00])

        // Init
        XCTAssertEqual(Bool(bytes: [0x01]), true)
        XCTAssertEqual(Bool(bytes: [0x00]), false)
        XCTAssertNil(Bool(bytes: [0x01, 0x00]))
    }

    func testCollection() {
        // Hex
        XCTAssertEqual([UInt8]([0x00, 0x01, 0x02, 0x03, 0x04, 0x0f]).hex, "00010203040f")
        XCTAssertEqual(Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x0f]).hex, "00010203040f")

        // Compact Map Concurrently
        XCTAssertEqual(Set([0xaa, 0xbb, 0x44, 0x77].compactMapConcurrently { String(format: "%02x", $0) }), Set(["aa", "bb", "44", "77"]))
    }

    func testDate() {
        // Bytes
        XCTAssertEqual(Date(timeIntervalSince1970: 1_554_454_340.0).bytes, [0x00, 0x00, 0x01, 0x69, 0xEC, 0xB2, 0xE1, 0xA0])

        // Init
        XCTAssertEqual(Date(bytes: [0x00, 0x00, 0x01, 0x69, 0xEC, 0xB2, 0xE1, 0xA0]), Date(timeIntervalSince1970: 1_554_454_340.0))
        XCTAssertNil(Date(bytes: [0x00, 0x00, 0x01, 0x69]))
    }

    func testDouble() {
        // Bytes
        XCTAssertEqual(Double(567.89).bytes, [0x40, 0x81, 0xBF, 0x1E, 0xB8, 0x51, 0xEB, 0x85])

        // Init
        XCTAssertEqual(Double(bytes: [0x40, 0x81, 0xBF, 0x1E, 0xB8, 0x51, 0xEB, 0x85]), 567.89)
        XCTAssertNil(Double(bytes: [0x40, 0x81, 0xBF, 0x1E]))
    }

    func testFloat() {
        // Bytes
        XCTAssertEqual(Float(123.45).bytes, [0x42, 0xF6, 0xE6, 0x66])

        // Init
        XCTAssertEqual(Float(bytes: [0x42, 0xF6, 0xE6, 0x66]), 123.45)
        XCTAssertNil(Float(bytes: [0x42, 0xF6]))
    }

    func testSignedInteger() {
        // UInt8
        XCTAssertEqual(1200.uint8, 0xB0)
        XCTAssertEqual((-654).uint8, (0xFF - 0x8E + 1))
    }

    func testString() {
        // Hex Bytes
        XCTAssertEqual("001122AABBCC".hexBytes, [0x00, 0x11, 0x22, 0xAA, 0xBB, 0xCC])

        // Bytes
        XCTAssertEqual("tere".bytes, [0x74, 0x65, 0x72, 0x65])

        // Init
        XCTAssertEqual(String(bytes: [0x74, 0x65, 0x72, 0x65]), "tere")
        XCTAssertNil(String(bytes: [0xF4, 0xF5, 0xF2, 0xF5]))

        // Character Pairs
        XCTAssertEqual("001122AABBCC".characterPairs, ["00", "11", "22", "AA", "BB", "CC"])
        XCTAssertEqual("0x00, 0x11, 0x22, 0xAA, 0xBB, 0xCC, 0xD".characterPairs, ["00", "11", "22", "AA", "BB", "CC", "D"])
    }

    func testURL() {
        guard let url = URL(string: "https://high-mobility.com") else {
            return XCTFail("Failed to initialise URL")
        }

        // Bytes
        XCTAssertEqual(url.bytes, [0x68, 0x74, 0x74, 0x70, 0x73, 0x3A, 0x2F, 0x2F, 0x68, 0x69, 0x67, 0x68, 0x2D, 0x6D, 0x6F, 0x62, 0x69, 0x6C, 0x69, 0x74, 0x79, 0x2E, 0x63, 0x6F, 0x6D])

        // Init
        XCTAssertEqual(URL(bytes: [0x68, 0x74, 0x74, 0x70, 0x73, 0x3A, 0x2F, 0x2F, 0x68, 0x69, 0x67, 0x68, 0x2D, 0x6D, 0x6F, 0x62, 0x69, 0x6C, 0x69, 0x74, 0x79, 0x2E, 0x63, 0x6F, 0x6D]), url)
        XCTAssertNil(URL(bytes: [0xF1, 0xF2, 0xF3]))
    }
}
