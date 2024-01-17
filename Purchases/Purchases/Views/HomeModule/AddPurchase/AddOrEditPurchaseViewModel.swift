//
//  AddPurchaseViewModel.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import Foundation

final class AddOrEditPurchaseViewModel<R: HomeRouter> {
    
    // MARK: - Properties
    
    var purchase: Purchase?
    
    private let router: R
    private let store: PurchaseStore
    
    // MARK: - Initializers
    
    init(router: R,
         store: PurchaseStore = RealmRepository()) {
        self.router = router
        self.store = store
    }
    
    init(router: R,
         store: PurchaseStore = RealmRepository(), 
         purchase: Purchase) {
        self.router = router
        self.store = store
        self.purchase = purchase
    }
}

// MARK: - Navigation

extension AddOrEditPurchaseViewModel {
    
    func didTapBackButton() {
        router.exit()
    }
}

// MARK: - Store

extension AddOrEditPurchaseViewModel {
    
    func createOrEditItemWith(name: String,
                              desc: String,
                              price: String,
                              date: Date) {
        
        let purchase: Purchase = .init(name: name,
                                       desc: desc,
                                       price: Int(price) ?? 0,
                                       date: date.toInt())
        
        Task { @MainActor [unowned self]  in
            do {
                self.purchase == nil ?
                try store.create(purchase: purchase) :
                try store.update(id: self.purchase!.id, name: name, desc: desc, price: Int(price) ?? 0, date: date.toInt())
                didTapBackButton()
                didTapBackButton()
                router.process(route: .showDetailview(self.purchase!.id.stringValue))
            } catch {
                print(error)
            }
        }
    }
}
