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
//  HMDebugTree.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 20/02/2019.
//

import Foundation


@frozen public enum HMDebugTree {

    case leaf(label: String)
    case node(label: String, nodes: [HMDebugTree])


    // MARK: Vars

    public var label: String {
        switch self {
        case .leaf(let label):
            return label

        case .node(let label, _):
            return label
        }
    }

    public var stringValue: String {
        return stringValue("")
    }


    // MARK: Methods

    public func visualise() {
        visualise("")
    }


    // MARK: Init

    public init(_ anything: Any, label: String? = nil, expandProperties: Bool = false, customValue: ((Any, String, Bool) -> HMDebugTree?)? = nil) {
        let mirror = Mirror(reflecting: anything)
        let label = label ?? "\(type(of: anything))"

        if let value = customValue?(anything, label, expandProperties) {
            self = value
        }
        else if let displayStyle = mirror.displayStyle {
            switch displayStyle {
            case .collection:
                if let array = anything as? Array<UInt8> {
                    self = .leaf(label: label + " = " + array.hex)
                }
                else if let array = anything as? Array<Any> {
                    self = .node(label: label, nodes: array.map { HMDebugTree($0, expandProperties: expandProperties, customValue: customValue) })
                }
                else {
                    self = .leaf(label: label)
                }

            case .`enum`:
                self = .leaf(label: "\(label) = \(anything)")

            case .optional:
                if let value = mirror.children.first?.value {
                    self = HMDebugTree(value, label: label, expandProperties: expandProperties, customValue: customValue)
                }
                else {
                    self = .leaf(label: label + " = nil")
                }

            case .`struct`:
                // A horrible way to (try to) handle OptionSets
                if anything is CustomStringConvertible, mirror.children.count == 1, mirror.children.first?.label == "rawValue" {
                    self = .leaf(label: "\(label) = \(anything)")
                }
                else {
                    // Pass the iVar label onward
                    let nodes = mirror.children.map { HMDebugTree($0.value, label: $0.label, expandProperties: expandProperties, customValue: customValue) }

                    self = .node(label: label, nodes: nodes)
                }

            case .tuple:
                let nodes = mirror.children.map { HMDebugTree($0.value, label: $0.label, expandProperties: expandProperties, customValue: customValue) }

                self = .node(label: label, nodes: nodes)

            case .class:
                let nodes = mirror.children.map { HMDebugTree($0.value, label: $0.label, expandProperties: expandProperties, customValue: customValue) }

                self = .node(label: label, nodes: nodes)

            default:
                self = .leaf(label: label)
            }
        }
        else {
            // Meaning it's a "simple" type – int, float, string, etc.
            self = .leaf(label: "\(label) = \(anything)")
        }
    }
}

private extension HMDebugTree {

    func stringValue(_ prefix: String) -> String {
        switch self {
        case .leaf(let label):
            return prefix + label + "\n"

        case .node(let label, let nodes):
            return prefix + label + " =\n" + nodes.map { $0.stringValue("\t" + prefix) }.joined()
        }
    }

    func visualise(_ prefix: String) {
        switch self {
        case .leaf(let label):
            print(prefix + label)

        case .node(let label, let nodes):
            print(prefix + label + " =")

            nodes.forEach {
                $0.visualise("\t" + prefix)
            }
        }
    }
}
