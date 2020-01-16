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
//  UInt8Collection+Extensions.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 15/03/2018.
//

import Foundation


public extension Collection where Element == UInt8 {

    var bytes: [UInt8] {
        guard let array = self as? [UInt8] else {
            return Array(self)
        }

        return array
    }

    var data: Data {
        guard let data = self as? Data else {
            return Data(self)
        }

        return data
    }

    /// The combined *hex* string representation of the values in the collection.
    var hex: String {
        return map { String(format: "%02x", $0) }.joined()
    }
}

public extension Collection where Index == Int {

    func compactMapConcurrently<ElementOfResult>(_ transform: (Element) -> ElementOfResult?) -> [ElementOfResult] {
        let lock = NSLock()
        var results: [ElementOfResult] = []

        DispatchQueue.concurrentPerform(iterations: count) {
            guard let elementOfResult = transform(self[$0]) else {
                return
            }

            lock.lockUnlock {
                results.append(elementOfResult)
            }
        }

        return results
    }
}
