//
//  Date.swift
//  Purchases
//
//  Created by User on 1/15/24.
//

import Foundation

extension Date {
    func toInt() -> Int {
        Int(self.timeIntervalSince1970)
    }
}

extension Int {
    func toDate() -> Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }
}
