//
//  Purchase.swift
//  Purchases
//
//  Created by User on 1/6/24.
//

import Foundation

struct Purchase: Codable, Hashable {
    var id: UUID = .init()
    let name: String
    let description: String
    let price: Int
    let date: Int
}
