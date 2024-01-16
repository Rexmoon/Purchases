//
//  AddPurchaseViewModel.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import Foundation

final class AddPurchaseViewModel<R: HomeRouter> {
    
    // MARK: - Properties
    
    private let router: R
    private let store: PurchaseStore
    
    // MARK: - Initializers
    
    init(router: R,
         store: PurchaseStore = RealmRepository()) {
        self.router = router
        self.store = store
    }
}

// MARK: - Navigation

extension AddPurchaseViewModel {
    
    func didTapBackButton() {
        router.exit()
    }
}

// MARK: - Store

extension AddPurchaseViewModel {
    
    func createItemWith(name: String,
                        desc: String,
                        price: String,
                        date: Date) {
        let purchase: Purchase = .init(name: name, 
                                       desc: desc,
                                       price: Int(price) ?? 0,
                                       date: date.toInt())
        
        Task { @MainActor [unowned self]  in
            do {
                try store.create(purchase: purchase)
                didTapBackButton()
            } catch {
                print(error)
            }
        }
    }
}
