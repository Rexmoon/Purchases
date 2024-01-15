//
//  Purchase.swift
//  Purchases
//
//  Created by User on 1/6/24.
//

import RealmSwift

final class Purchase: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var desc: String
    @Persisted var price: Int
    @Persisted var date: Int
    @Persisted var status: String
    
    convenience init(name: String,
                     desc: String,
                     price: Int,
                     date: Int,
                     status: String = Status.available.rawValue) {
        self.init()
        self.name = name
        self.desc = desc
        self.price = price
        self.date = date
        self.status = status
    }
}

enum Status: String, PersistableEnum {
    case sold
    case available
    
    var rawValue: String {
        String(describing: self).capitalized
    }
}
