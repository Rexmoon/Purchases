//
//  Results.swift
//  Purchases
//
//  Created by User on 1/15/24.
//

import RealmSwift

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}
