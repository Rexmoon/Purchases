 //
//  ServiceManager.swift
//  Purchases
//
//  Created by User on 1/6/24.
//

import RealmSwift
import Foundation

final class RealmRepository {
    
    private let realm: Realm = try! .init()
}

// MARK: - Purchase Repository Delegate

extension RealmRepository: PurchaseStore {
    func create(purchase: Purchase) throws {
        do {
            try realm.write {
                realm.add(purchase)
            }
        } catch {
            throw StoreError.generic(error)
        }
    }
    
    func read() throws -> [Purchase] {
        realm.objects(Purchase.self).toArray(type: Purchase.self)
    }
    
    func update(id: ObjectId,
                name: String,
                desc: String,
                price: Int,
                date: Int) throws {
        guard
            let purchaseToEdit = realm.objects(Purchase.self).first(where: { $0.id == id })
        else {
            throw StoreError.updating
        }
        
        do {
            try realm.write {
                purchaseToEdit.name = name
                purchaseToEdit.desc = desc
                purchaseToEdit.price = price
                purchaseToEdit.date = date
            }
        } catch {
            throw StoreError.generic(error)
        }
    }
    
    func delete(by id: ObjectId) throws {
        do {
            try realm.write {
                guard 
                    let purchaseToDelete = realm.objects(Purchase.self).first(where: { $0.id == id })
                else {
                    throw StoreError.deleting
                }
                realm.delete(purchaseToDelete)
            }
        } catch {
            throw StoreError.deleting
        }
    }
    
    func get(by id: String) throws -> Purchase {
        do {
            let id = try ObjectId(string: id)
            
            guard 
                let purchase = realm.object(ofType: Purchase.self, forPrimaryKey: id)
            else {
                throw StoreError.reading
            }
            
            return purchase
        } catch {
            throw StoreError.generic(error)
        }
    }
}
