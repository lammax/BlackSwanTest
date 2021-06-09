//
//  String+adds.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import Foundation

@available (macOS 10.15, * )
extension String {
    subscript(idx: UInt) -> Character {
        self[index(startIndex, offsetBy: Int(idx).quotientAndRemainder(dividingBy: 26).remainder)]
    }
}
