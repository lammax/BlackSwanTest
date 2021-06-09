//
//  Date+adds.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: self)
    }
}
