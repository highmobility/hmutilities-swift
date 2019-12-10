//
// AutoAPI CLT
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
//  HMDebugTree.swift
//  HMUtilities
//
//  Created by Mikk Rätsep on 20/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public enum HMDebugTree {

    case leaf(label: String)
    case node(label: String, nodes: [HMDebugTree])


    // MARK: Vars

    public var label: String {
        switch self {
        case .leaf(let label):
            return label

        case .node(let label, nodes: _):
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
