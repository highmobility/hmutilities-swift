//
//  String+Extensions.swift
//  HMCryptoKitCLT
//
//  Created by Mikk Rätsep on 07/03/2018.
//

import Foundation


public extension String {

    var bytes: [UInt8] {
        return characterPairs.flatMap { UInt8($0, radix: 16) }
    }
}

extension String {

    var characterPairs: [String] {
        let startEmptyStringPairsArray: [String] = []

        return enumerated().reduce(startEmptyStringPairsArray) { (midResult, enumerationTuple) in
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
