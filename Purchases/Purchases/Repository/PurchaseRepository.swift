//
//  PurchaseRepository.swift
//  Purchases
//
//  Created by User on 1/6/24.
//

protocol PurchaseRepository {
    func create() async throws
    func read() async throws
    func update() async throws
    func delete() async throws
}
