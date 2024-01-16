//
//  PurchaseRepository.swift
//  Purchases
//
//  Created by User on 1/6/24.
//

import RealmSwift

protocol PurchaseStore {
    func create(purchase: Purchase) throws
    func read() throws -> [Purchase]
    func update(id: ObjectId) throws
    func delete(id: ObjectId) throws
    func get(by id: String) throws -> Purchase
}
